public class QBMap {
    
    public static String mapContactData(Contact con){
        System.debug('Contact ' + con);
        System.debug('Contact QB ID' + con.QBO_Id__c);
        System.debug('Contact QB Token' + con.QBO_SyncToken__c);

        QBCustomerJSON.Customer customer = new QBCustomerJSON.Customer();
        customer.FullyQualifiedName = con.Name;
        customer.GivenName = con.FirstName;
        customer.FamilyName = con.LastName;
        customer.CompanyName = con.account.Name;
        customer.Taxable = True;
        customer.SyncToken = con.QBO_SyncToken__c;
        customer.sparse = True;
        customer.PrintOnCheckName = con.Account.Name;
        
        QBCustomerJSON.PrimaryPhone phone = new QBCustomerJSON.PrimaryPhone();
        System.debug('con.Phone'+con.Phone);
        phone.FreeFormNumber = con.Phone;
        customer.PrimaryPhone = phone;
        
        QBCustomerJSON.PrimaryEmailAddr email = new QBCustomerJSON.PrimaryEmailAddr();
        email.Address = con.Email;
        customer.PrimaryEmailAddr = email; 
        
        customer.BillWithParent = True;
        customer.Job = false;
        customer.IsProject = False;
        customer.Id = con.QBO_ID__c;
        
        QBCustomerJSON.BillAddr billAddy = new QBCustomerJSON.BillAddr();
        billAddy.City = con.Account.BillingCity;
        billAddy.Line1 = con.Account.BillingStreet;
        billAddy.CountrySubDivisionCode = con.Account.BillingState;
        billAddy.PostalCode = con.Account.BillingPostalCode;
        billAddy.Country = con.Account.BillingCountry;
        customer.BillAddr = billAddy;
        
        QBCustomerJSON.BillAddr shipAddy = new QBCustomerJSON.BillAddr();
        shipAddy.City = con.Account.ShippingCity;
        shipAddy.Line1 = con.Account.ShippingStreet;
        shipAddy.CountrySubDivisionCode = con.Account.ShippingState;
        shipAddy.PostalCode = con.Account.ShippingPostalCode;
        shipAddy.Country = con.Account.ShippingCountry;
        customer.ShipAddr = shipAddy;
        
        
        customer.Active = True;
        return JSON.serialize(customer, True);
    }
    
    public static String mapAccountData(Account acc){
        QBAccountJSON.Account qba = new QBAccountJSON.Account();
        qba.Id = acc.QBO_Id__c;
        qba.SyncToken = acc.QBO_SyncToken__c;
        qba.Name = acc.Name;
        qba.AccountType = 'Accounts Receivable';
        return JSON.serialize(qba, True);
    }
    
    public static String mapProductData(Product2 product){
        
        QBProductJSON.Item js = new QBProductJSON.Item();
        
        js.Name = product.Name;
        js.Id = product.QBO_Id__c;
        js.SyncToken = product.QBO_SyncToken__c;
        js.Sku = product.Id;
        js.QtyOnHand = 20; 
        js.Type = 'Inventory';
        js.TrackQtyOnHand = true;
        js.InvStartDate = String.valueOf(System.today());
        js.Description = product.Description;
        js.sparse = true;
        js.Active = true;
        
        QBProductJSON.ExpenseAccountRef eaf = new QBProductJSON.ExpenseAccountRef();
        eaf.name = 'Cost of Goods Sold';
        eaf.value = '80';
        js.ExpenseAccountRef = eaf;
        
        QBProductJSON.AssetAccountRef aaf = new QBProductJSON.AssetAccountRef();
        aaf.name = 'Inventory Asset';
        aaf.value = '81';
        js.AssetAccountRef = aaf;
        
        QBProductJSON.IncomeAccountRef iar = new QBProductJSON.IncomeAccountRef();
        iar.name = 'Sales of Product Income';
        iar.value = '79';
        js.IncomeAccountRef = iar;
		js.PurchaseCost = 100;
        return JSON.serialize(js, True);
    }
  
}