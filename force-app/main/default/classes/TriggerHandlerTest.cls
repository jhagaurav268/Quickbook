@isTest
public class TriggerHandlerTest {
    public static Boolean isContactInsert = false;
    public static Boolean isScooterInsert = false;
    public static Boolean isTransactionInsert = false;
    public static Boolean isAccountInsert = false;
    
    @TestSetup
    static void setupTestData() {
        QB_Data__c customSetting = new QB_Data__c(
            Name = 'Test Setting',
            Refresh_Token__c = 'AB11701070273xxgelsiCvmgX3jR9qWeMA8Ptl5Pk9yjTvydvD',
            Client_Id__c = 'ABFnpCySddaUc9ryPiwaktvT6V7yf9lKVXH0gc1pBftZhC0RmH',
            Client_Secret__c = 'LOKTDJAwbvgQAjhKblCYM4fgqkXGj1ZKf3RWRZQ6',
            Auth_Url__c = 'https://oauth.platform.intuit.com/oauth2/v1/tokens/bearer'
        );
        insert customSetting;
    }
    
    private class MyMock implements HttpCalloutMock {
        public HttpResponse respond(HttpRequest request) {
            system.debug('Endpoint ' + request.getEndpoint());
            if(request.getEndpoint() == 'https://oauth.platform.intuit.com/oauth2/v1/tokens/bearer'){
                HttpResponse res = new HttpResponse();
                res.setStatusCode(200);
                res.setBody('{"x_refresh_token_expires_in": 3600,"refresh_token": "AB11701070273xxgelsiCvmgX3jR9qWeMA8Ptl5Pk9yjTvydvD","access_token": "eyJlbmMiOiJBMTI4Q0JDLUhTMjU2IiwiYWxnIjoiZGlyIn0..4v7peOlx_kaSfRrPOj18ag._1yRj9tDerghfUAE0n-I-7qx2eokVr8sN64lRIIffl9t5uA0HCkF3XroHKvFGzCSS0L54laWrK_Yc-dD3E8Hrs_Ch1B9BC6I1PeR0H5kbxTaiGy99HqwkD9l6xOA9JfwscGpL1D0u5IfuTovBr84KW30qn-3IkQzR9j_PmfP4Zv86uHqO67ueJPo-I-ihMMyDmIl-muEOVLxYWvJJTDfVPqE0yTmOWQgWUdlXcrp7EckIY5-Fm2rA0t2VpJGpBH2eCGHRG95BVo-j6rj-dxOgoh4D_3UzXCagpt2QPMg96lc5jIBxBMuEf4vECeX9FqrDXmCAIgAldl4r1XW7sBiebNU_RuO1qCShUZZtK3GHte6ykw6u1R7Zhq24Rm18eb-7YB5PtoQdH9eLSIezdxYaFHS2EDgzOzj9LQO5S7_KcExRQiTwY3xbtYTsZEUKu4gbRZXayqRyCq1H4ysonq8fqsE0oiF6DOOp6AJGGc641Vt6EIGN-VzUFCSyAMaclqsg2_cq1sJQcu8pG2rnvbWWgi4kDr4bt8PXQn6dm1v_q2MmmVvoIORzd5d-ZTXaAkjFWgpGjlOkM8CTTSMm4YOrgH_AAcAxwTrwl3y8tmSRRF7si-V6eDOnzIOuwwDNlhFDi_i0icA9Y4rgKhbDVU6d-BMZyzPbA46OBUP1aIUpMYN7i-GdFiYOHCtk0wNsDunygsiwTSB1_CP5q7HHrviF8mZB5y3VYQ24mnT4ii2lAANeigjIFtW904wVSmbOMN_.8svXs55D9QBI_jIDDkNgkw","expires_in": "3600","token_type": "Bearer"}');
                return res;
            }else if(request.getEndpoint() == 'https://sandbox-quickbooks.api.intuit.com/v3/company/4620816365323855930/query?minorversion=65'){
                HttpResponse res = new HttpResponse();
                res.setStatusCode(200);
                if(isContactInsert == true){
                    res.setBody('{"QueryResponse":{"Customer":[{"Taxable":true,"BillAddr":{"Id":"146","Line1":"123 Main Street","City":"Mountain View","Country":"USA","CountrySubDivisionCode":"CA","PostalCode":"94042"},"Notes":"Here are other details.","Job":false,"BillWithParent":false,"Balance":0,"BalanceWithJobs":0,"CurrencyRef":{"value":"USD","name":"United States Dollar"},"PreferredDeliveryMethod":"Print","IsProject":false,"ClientEntityId":"0","domain":"QBO","sparse":false,"Id":"73","SyncToken":"0","MetaData":{"CreateTime":"2023-08-14T02:06:10-07:00","LastUpdatedTime":"2023-08-14T02:06:10-07:00"},"Title":"Mr","GivenName":"James","MiddleName":"B","FamilyName":"King","Suffix":"Jr","FullyQualifiedName":"gaurav Jha","CompanyName":"Gaurav Jha","DisplayName":"gaurav Jha","PrintOnCheckName":"Gaurav Jha","Active":true,"V4IDPseudonym":"0020982b909e965d8648129e62d0c8ec2dba99","PrimaryPhone":{"FreeFormNumber":"(555) 555-5555"},"PrimaryEmailAddr":{"Address":"jdrew@myemail.com"}}],"startPosition":1,"maxResults":1},"time":"2023-08-14T02:07:18.437-07:00"}');
                }else if(isScooterInsert == true){
                    res.setBody('{"QueryResponse":{"Item":[{"Name":"Garden Supplies","Active":true,"FullyQualifiedName":"Garden Supplies","Taxable":false,"UnitPrice":0,"Type":"Inventory","IncomeAccountRef":{"value":"79","name":"Sales of Product Income"},"PurchaseCost":0,"ExpenseAccountRef":{"value":"80","name":"Cost of Goods Sold"},"AssetAccountRef":{"value":"81","name":"Inventory Asset"},"TrackQtyOnHand":true,"QtyOnHand":10,"InvStartDate":"2015-01-01","domain":"QBO","sparse":false,"Id":"35","SyncToken":"0","MetaData":{"CreateTime":"2023-07-25T00:08:04-07:00","LastUpdatedTime":"2023-07-25T00:08:04-07:00"}}],"startPosition":1,"maxResults":1},"time":"2023-08-14T02:36:29.819-07:00"}');
                }else if(isTransactionInsert == true){
                    res.setBody('{"QueryResponse":{"Invoice":[{"AllowIPNPayment":false,"AllowOnlinePayment":false,"AllowOnlineCreditCardPayment":false,"AllowOnlineACHPayment":false,"domain":"QBO","sparse":false,"Id":"233","SyncToken":"0","MetaData":{"CreateTime":"2023-08-14T02:49:33-07:00","LastModifiedByRef":{"value":"9130356916531226"},"LastUpdatedTime":"2023-08-14T02:49:33-07:00"},"CustomField":[{"DefinitionId":"1","Name":"CustomFIeldOne","Type":"StringType"},{"DefinitionId":"2","Name":"CustomFIeldTwo","Type":"StringType"},{"DefinitionId":"3","Name":"CustomFIeldThre","Type":"StringType"}],"DocNumber":"1074","TxnDate":"2023-08-14","CurrencyRef":{"value":"USD","name":"United States Dollar"},"LinkedTxn":[],"Line":[{"Id":"1","LineNum":1,"Amount":100,"DetailType":"SalesItemLineDetail","SalesItemLineDetail":{"ItemRef":{"value":"1","name":"Services"},"ItemAccountRef":{"value":"1","name":"Services"},"TaxCodeRef":{"value":"NON"}}},{"Amount":100,"DetailType":"SubTotalLineDetail","SubTotalLineDetail":{}}],"TxnTaxDetail":{"TotalTax":0},"CustomerRef":{"value":"1","name":"Amys Bird Sanctuary"},"BillAddr":{"Id":"2","Line1":"4581 Finch St.","City":"Bayshore","CountrySubDivisionCode":"CA","PostalCode":"94326","Lat":"INVALID","Long":"INVALID"},"ShipAddr":{"Id":"2","Line1":"4581 Finch St.","City":"Bayshore","CountrySubDivisionCode":"CA","PostalCode":"94326","Lat":"INVALID","Long":"INVALID"},"FreeFormAddress":true,"ShipFromAddr":{"Id":"147","Line1":"123 Sierra Way","Line2":"San Pablo, CA  87999"},"DueDate":"2023-09-13","TotalAmt":100,"ApplyTaxAfterDiscount":false,"PrintStatus":"NeedToPrint","EmailStatus":"NotSet","Balance":100}],"startPosition":1,"maxResults":1,"totalCount":1},"time":"2023-08-14T02:50:04.110-07:00"}');
                }else if(isAccountInsert == true){
                    res.setBody('{"QueryResponse":{"Account":[{"FullyQualifiedName":"Testing Account test","domain":"QBO","Name":"Testing Account test","Classification":"Asset","AccountSubType":"AccountsReceivable","CurrentBalanceWithSubAccounts":0,"sparse":true,"AccountType":"Accounts Receivable","CurrentBalance":0,"Active":"true","SyncToken":"0","Id":"93","SubAccount":"false","CurrencyRef":{"name":"USD","value":"United States Dollar"},"MetaData":{"CreateTime":"2023-08-14T10:30:00Z","LastUpdatedTime":"2023-08-14T15:45:00Z"}}],"startPosition":1}}');
                }else{
                    res.setBody('{"QueryResponse": "","time": "2023-08-09T06:01:56.267-07:00"}');
                }
                return res;
            }else if(request.getEndpoint() == 'https://sandbox-quickbooks.api.intuit.com/v3/company/4620816365323855930/account?minorversion=65'){
                HttpResponse res = new HttpResponse();
                res.setStatusCode(200);
                res.setBody('{"Account":{"Name":"Testing Account test","SubAccount":false,"Description":"Description added during update.","FullyQualifiedName":"Testing Account test","Active":true,"Classification":"Asset","AccountType":"Accounts Receivable","AccountSubType":"AccountsReceivable","CurrentBalance":0,"CurrentBalanceWithSubAccounts":0,"CurrencyRef":{"value":"USD","name":"United States Dollar"},"domain":"QBO","sparse":false,"Id":"93","SyncToken":"1","MetaData":{"CreateTime":"2023-08-14T03:26:22-07:00","LastUpdatedTime":"2023-08-14T03:29:42-07:00"}},"time":"2023-08-14T03:29:42.504-07:00"}');
                return res;
            }else if(request.getEndpoint() == 'https://sandbox-quickbooks.api.intuit.com/v3/company/4620816365323855930/customer?minorversion=65'){
                HttpResponse res = new HttpResponse();
                res.setStatusCode(200);
                res.setBody('{"Customer":{"Taxable":true,"BillAddr":{"Id":"146","Line1":"123 Main Street","City":"Mountain View","Country":"USA","CountrySubDivisionCode":"CA","PostalCode":"94042"},"Job":false,"BillWithParent":false,"Balance":0,"BalanceWithJobs":0,"CurrencyRef":{"value":"USD","name":"United States Dollar"},"PreferredDeliveryMethod":"Print","IsProject":false,"domain":"QBO","sparse":false,"Id":"73","SyncToken":"1","MetaData":{"CreateTime":"2023-08-14T02:06:10-07:00","LastUpdatedTime":"2023-08-14T02:13:01-07:00"},"GivenName":"James","MiddleName":"B","FamilyName":"King","FullyQualifiedName":"gaurav Jha","CompanyName":"Gaurav Jha","DisplayName":"gaurav Jha","PrintOnCheckName":"Gaurav","Active":true,"PrimaryPhone":{"FreeFormNumber":"(555) 555-5555"},"PrimaryEmailAddr":{"Address":"jdrew@myemail.com"},"DefaultTaxCodeRef":{"value":"2"}},"time":"2023-08-14T02:13:01.252-07:00"}');
                return res;
            }else if(request.getEndpoint() == 'https://sandbox-quickbooks.api.intuit.com/v3/company/4620816365323855930/item?minorversion=65'){
                HttpResponse res = new HttpResponse();
                res.setStatusCode(200);
                res.setBody('{"Item":{"FullyQualifiedName":"Garden Supplies","domain":"QBO","Id":"35","Name":"Garden Supplies","TrackQtyOnHand":true,"UnitPrice":0,"PurchaseCost":0,"QtyOnHand":10,"IncomeAccountRef":{"name":"Sales of Product Income","value":"79"},"AssetAccountRef":{"name":"Inventory Asset","value":"81"},"Taxable":false,"sparse":false,"Active":true,"SyncToken":"1","InvStartDate":"2015-01-01","Type":"Inventory","ExpenseAccountRef":{"name":"Cost of Goods Sold","value":"80"},"MetaData":{"CreateTime":"2015-12-09T11:12:39-08:00","LastUpdatedTime":"2015-12-09T11:12:41-08:00"}},"time":"2015-12-09T11:12:39.748-08:00"}');
                return res;
            }else if(request.getEndpoint() == 'https://sandbox-quickbooks.api.intuit.com/v3/company/4620816365323855930/invoice?minorversion=65'){
                HttpResponse res = new HttpResponse();
                res.setStatusCode(200);
                res.setBody('{"Invoice":{"AllowIPNPayment":false,"AllowOnlinePayment":false,"AllowOnlineCreditCardPayment":false,"AllowOnlineACHPayment":false,"domain":"QBO","sparse":false,"Id":"233","SyncToken":"1","MetaData":{"CreateTime":"2023-08-14T02:49:33-07:00","LastModifiedByRef":{"value":"9130356916531226"},"LastUpdatedTime":"2023-08-14T02:52:40-07:00"},"CustomField":[{"DefinitionId":"1","Name":"CustomFIeldOne","Type":"StringType"},{"DefinitionId":"2","Name":"CustomFIeldTwo","Type":"StringType"},{"DefinitionId":"3","Name":"CustomFIeldThre","Type":"StringType"}],"DocNumber":"1070","TxnDate":"2015-07-24","CurrencyRef":{"value":"USD","name":"United States Dollar"},"LinkedTxn":[],"Line":[{"Id":"1","LineNum":1,"Amount":150,"DetailType":"SalesItemLineDetail","SalesItemLineDetail":{"ItemRef":{"value":"1","name":"Services"},"ItemAccountRef":{"value":"1","name":"Services"},"TaxCodeRef":{"value":"NON"}}},{"Amount":150,"DetailType":"SubTotalLineDetail","SubTotalLineDetail":{}}],"TxnTaxDetail":{"TotalTax":0},"CustomerRef":{"value":"1","name":"Amys Bird Sanctuary"},"CustomerMemo":{"value":"Added customer memo."},"BillAddr":{"Id":"2","Line1":"4581 Finch St.","City":"Bayshore","CountrySubDivisionCode":"CA","PostalCode":"94326","Lat":"INVALID","Long":"INVALID"},"ShipAddr":{"Id":"2","Line1":"4581 Finch St.","City":"Bayshore","CountrySubDivisionCode":"CA","PostalCode":"94326","Lat":"INVALID","Long":"INVALID"},"FreeFormAddress":true,"ShipFromAddr":{"Id":"147","Line1":"123 Sierra Way","Line2":"San Pablo, CA  87999"},"DueDate":"2015-08-23","TotalAmt":150,"ApplyTaxAfterDiscount":false,"PrintStatus":"NeedToPrint","EmailStatus":"NotSet","Balance":150},"time":"2023-08-14T02:52:40.164-07:00"}');
                return res;
            }else {
                return null;
            }
        }
    }
    
    @isTest
    public static void syncAccountTest(){
        Test.setMock(HttpCalloutMock.class, new MyMock());
        Account acc = new Account(Name = 'Testing Account test', Phone = '6543164836');
        insert acc;
        try{
            isAccountInsert = true;
            acc.Phone = '9485987048';
            update acc;
        }Catch(exception ex){
            System.debug('ex' + ex.getMessage());
        }
    }
    
    @isTest
    public static void syncContact(){
        Test.setMock(HttpCalloutMock.class, new MyMock());
        Contact con = new Contact(FirstName = 'Testing', LastName = 'data', Email = 'testingcon@gmail.com');
        insert con;
        try{
            isContactInsert = true;
            con.Email = 'contest@gmail.com';
            update con;   
        }Catch(Exception ex){
            System.debug('Exception ' + ex.getMessage());
        }
    }
    
    @isTest
    public static void syncScooter(){
        Test.setMock(HttpCalloutMock.class, new MyMock());
        Product2 prod = new Product2();
        prod.Name = 'Rachel Scooter';
        prod.ProductCode = 'PROD2767';
        insert prod;
        
        try{
            isScooterInsert = true;
            prod.Description = 'Testing';
            update prod;   
        }Catch(Exception ex){
            System.debug('Exception ' + ex.getMessage());
        }
    }
    
    static testMethod void errorJSONTest() {
        String json = '{\"Fault\":{\"Error\":[{\"Message\":\"A business validation error has occurred while processing your request\",\"Detail\":\"Business Validation Error: Were sorry, QuickBooks encountered an error while calculating tax. Try reselecting the tax rate or reentering the product/service item and saving the form again.\",\"code\":\"6000\",\"element\":\"\"}],\"type\":\"ValidationFault\"},\"time\":\"2019-11-06T21:40:41.673-08:00\"}';
        QBErrorJSON r = QBErrorJSON.parse(json);
        System.assert(r != null);
        
        json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
        QBErrorJSON objQBOErrorJSON = new QBErrorJSON(System.JSON.createParser(json));
        System.assert(objQBOErrorJSON != null);
        System.assert(objQBOErrorJSON.Fault == null);
        
        json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
        QBErrorJSON.Error objError = new QBErrorJSON.Error(System.JSON.createParser(json));
        System.assert(objError != null);
        System.assert(objError.Message == null);
        System.assert(objError.Detail == null);
        System.assert(objError.code == null);
        
        json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
        QBErrorJSON.Fault objFault = new QBErrorJSON.Fault(System.JSON.createParser(json));
        System.assert(objFault != null);
        System.assert(objFault.Error == null);
    }
    
}