public class QBSync_Controller {
    public static void synchronizeContact(Set<Id> contactIds) {
        List<Contact> contactsToSync = [SELECT Id, Name, AccountId, Phone, Email, QBO_SyncToken__c, LastName, FirstName, QBO_Id__c, Account.BillingCity, Account.Name,
                                        Account.BillingStreet, Account.BillingState, Account.BillingPostalCode, Account.BillingCountry,
                                        Account.BillingLatitude, Account.BillingLongitude, Account.ShippingCity, Account.ShippingStreet,
                                        Account.ShippingState, Account.ShippingPostalCode, Account.ShippingCountry
                                        FROM Contact WHERE Id IN :contactIds];
        Map<Id, Contact> contactMapToUpdate = new Map<Id, Contact>();
        QBCallouts callout = new QBCallouts();
        
        for (Contact con : contactsToSync) {
            QBCustomerJSON conData = callout.getCustomer(con);
            if (conData.QueryResponse.Customer != null && conData.QueryResponse.Customer.size() == 1) {
                QBCustomerJSON.Customer c = conData.QueryResponse.Customer[0];
                con.QBO_Id__c = c.id;
                con.QBO_SyncToken__c = c.SyncToken;
                contactMapToUpdate.put(con.Id, con);
            }
            
            QBCustomerResponseJSON response = callout.createCustomerCall(con);

            if (response.Customer.Id != null || response.Customer.SyncToken != null) {
                if (contactMapToUpdate.containsKey(con.Id)) {
                    Contact contactToUpdate = contactMapToUpdate.get(con.Id);
                    contactToUpdate.QBO_Id__c = response.Customer.Id;
                    contactToUpdate.QBO_SyncToken__c = response.Customer.SyncToken;
                }
            }
        }
        
        callout.updateRefreshToken();
        
        if (!contactMapToUpdate.isEmpty()) {
            update contactMapToUpdate.values();
        }
    }
    
    public static void synchronizeAccount(Account acc) {
        QBCallouts callout = new QBCallouts();
        QBAccountJSON accData = callout.getAccount(acc);
        System.debug('queryJson accData' + accData);
        if (accData.QueryResponse.Account != null) {
            if (accData.QueryResponse.Account.size() == 1) {
                for (QBAccountJSON.Account a : accData.QueryResponse.Account) {
                    acc.QBO_Id__c = a.id;
                    acc.QBO_SyncToken__c = a.SyncToken;
                }
            } else {
                throw new ListException();
            }
        }
        
        QBAccountResponseJSON accountPushData = callout.createAccountCall(acc);
        
        if (accountPushData.Account.Id != null) {
            acc.QBO_ID__c = accountPushData.Account.Id;
        }
        if (accountPushData.Account.SyncToken != null) {
            acc.QBO_SyncToken__c = accountPushData.Account.SyncToken;
        }
        
        callout.updateRefreshToken();
        update acc;
    }
    
    public static void synchronizeProduct(Product2 prod) {
        QBCallouts callout = new QBCallouts();
        QBProductJSON productData = callout.getProduct(prod);
        
        if (productData.QueryResponse.Item != null) {
            if (productData.QueryResponse.Item.size() == 1) {
                for (QBProductJSON.Item c : productData.QueryResponse.Item) {
                    
                    prod.QBO_Id__c = c.id;
                    prod.QBO_SyncToken__c = c.SyncToken;
                    
                }
            } else {
                throw new ListException();
            }
        }
        
        QBProductResponseJSON itemPushData = callout.createProductCall(prod);
        
        if (itemPushData.Item.Id != null) {
            prod.QBO_ID__c = itemPushData.Item.Id;
        }
        if (itemPushData.Item.SyncToken != null) {
            prod.QBO_SyncToken__c = itemPushData.Item.SyncToken;
        }
        
        callout.updateRefreshToken();
        update prod;
    }
    
}