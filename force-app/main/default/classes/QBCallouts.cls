public class QBCallouts {
    private String accessToken{get;set;}
    private String refreshToken{get;set;}
    
    public QBCallouts() {
        List<String> tokens = refresh();
    }
    
    private List<String> refresh(){
        QB_Data__c QBData = [SELECT Id, Name, Refresh_Token__c, Client_Id__c, Client_Secret__c, Auth_Url__c FROM QB_Data__c];
        String url = QBData.Auth_Url__c;
        String clientId = QBData.Client_Id__c;
        String clientSecret = QBData.Client_Secret__c;
        String header = 'Basic ' + EncodingUtil.base64Encode(Blob.valueOf(clientId + ':' + clientSecret));
        String refresh_token = QBData.Refresh_Token__c;
        String body = 'grant_type=refresh_token&refresh_token='+refresh_token; 
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        HttpResponse res = new HttpResponse();
        req.setEndpoint(url);
        req.setMethod('GET');
        req.setBody(body);
        req.setHeader('Authorization', header);
        req.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        res = http.send(req);
        QBRefreshJSON json = QBRefreshJSON.parse(res.getBody());
        if(json.access_token == null){
            Throw new QBException('Refresh Token has Expired');
        }
        List<String> tokens = new List<String>{json.access_token, json.refresh_token};
            accessToken = tokens[0];
        refreshToken = tokens[1];
        return tokens;
    }
    
    public void updateRefreshToken(){
        QB_Data__c QBData = [SELECT Id, Name, Refresh_Token__c, Last_Updated__c FROM QB_Data__c];
        QBData.Refresh_Token__c = refreshToken;
        QBData.Last_Updated__c = DateTime.now();
        update QBData;
    }
    
    private static void handleResponseError(String body){
        QBErrorJSON error = QBErrorJSON.parse(body);
        if(error != null){
            if(error.Fault != null && error.Fault.Error != null && error.Fault.Error.size() > 0){
                Throw new QBException(String.valueOf(error.Fault.Error[0]));
            }
        }
    }
    
    public static String makeQuickBooksApiCall(String url, String method, String body, Map<String, String> headers) {
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        HttpResponse res = new HttpResponse();
        req.setEndpoint(url);
        req.setMethod(method);
        if (String.isNotBlank(body)) {
            req.setBody(body);
        }
        if (headers != null) {
            for (String key : headers.keySet()) {
                req.setHeader(key, headers.get(key));
            }
        }
        res = h.send(req);
        return res.getBody();
    }
    
    public QBCustomerJSON getCustomer(Contact con) {
        if (con == null) {
            throw new NullPointerException();
        }
        String query = 'Select * from Customer where DisplayName = \'' + con.Name + '\'';
        if (con.QBO_Id__c != null) {
            query = 'Select * from Customer where Id = \'' + con.QBO_Id__c + '\'';
        }
        QB_Metadata__mdt QBData = [SELECT Id, Base_Url__c, Company_Id__c, Minor_Version__c FROM QB_Metadata__mdt];
        String url = QBData.Base_Url__c + '/v3/company/' + QBData.Company_Id__c + '/query?minorversion=' + QBData.Minor_Version__c;
        Map<String, String> headers = new Map<String, String>{'Authorization' => 'Bearer ' + accessToken,'Accept' => 'application/json','Content-Type' => 'application/text'};
            String responseJson = makeQuickBooksApiCall(url, 'POST', query, headers);
        handleResponseError(responseJson);
        QBCustomerJSON json = QBCustomerJSON.parse(responseJson);
        return json;
    }
    
    public QBCustomerResponseJSON createCustomerCall(Contact con) {
        String body = QBMap.mapContactData(con);
        QB_Metadata__mdt QBData = [SELECT Id, Base_Url__c, Company_Id__c, Minor_Version__c FROM QB_Metadata__mdt];
        String url = QBData.Base_Url__c + '/v3/company/' + QBData.Company_Id__c + '/customer?minorversion=' + QBData.Minor_Version__c;     
        Map<String, String> headers = new Map<String, String>{'Authorization' => 'Bearer ' + accessToken,'Accept' => 'application/json','Content-Type' => 'application/json'};
            String responseJson = makeQuickBooksApiCall(url, 'POST', body, headers);
        handleResponseError(responseJson);
        QBCustomerResponseJSON json = QBCustomerResponseJSON.parse(responseJson);
        return json;
    }
    
    public QBAccountJSON getAccount(Account acc){
        if(acc == null){
            Throw new NullPointerException();
        }
        String query = 'Select * from account where name = \'' + acc.Name + '\'';
        if(acc.QBO_Id__c != null){
            query = 'Select * from account where Id = \'' + acc.QBO_Id__c + '\'';
        }
        QB_Metadata__mdt QBData = [SELECT Id, Base_Url__c, Company_Id__c, Minor_Version__c FROM QB_Metadata__mdt];
        String url = QBData.Base_Url__c + '/v3/company/' + QBData.Company_Id__c + '/query?minorversion=' + QBData.Minor_Version__c;
        Map<String, String> headers = new Map<String, String>{'Authorization' => 'Bearer ' + accessToken,'Accept' => 'application/json','Content-Type' => 'application/text'};
            String responseJson = makeQuickBooksApiCall(url, 'POST', query, headers);
        handleResponseError(responseJson);
        QBAccountJSON json = QBAccountJSON.parse(responseJson);
        System.debug('json acc '+ json);
        return json;
    }
    
    public QBAccountResponseJSON createAccountCall(Account acc){
        String body = QBMap.mapAccountData(acc);
        QB_Metadata__mdt QBData = [SELECT Id, Base_Url__c, Company_Id__c, Minor_Version__c FROM QB_Metadata__mdt];
        String url = QBData.Base_Url__c + '/v3/company/' + QBData.Company_Id__c + '/account?minorversion=' + QBData.Minor_Version__c;
        Map<String, String> headers = new Map<String, String>{'Authorization' => 'Bearer ' + accessToken,'Accept' => 'application/json','Content-Type' => 'application/json'};
            String responseJson = makeQuickBooksApiCall(url, 'POST', body, headers);
        handleResponseError(responseJson);
        QBAccountResponseJSON json = QBAccountResponseJSON.parse(responseJson);
        return json;
    }

     public QBProductJSON getProduct(Product2 product){
        if(product == null){
            Throw new NullPointerException();
        }
        String query = 'Select * from Item where Name = \'' + product.Name + '\'';
        
        if(product.QBO_Id__c != null){
            query = 'Select * from Item where Id = \'' + product.QBO_Id__c + '\'';
        }

         QB_Metadata__mdt QBData = [SELECT Id, Base_Url__c, Company_Id__c, Minor_Version__c FROM QB_Metadata__mdt];
        String url = QBData.Base_Url__c + '/v3/company/' + QBData.Company_Id__c + '/query?minorversion=' + QBData.Minor_Version__c;
        Map<String, String> headers = new Map<String, String>{'Authorization' => 'Bearer ' + accessToken,'Accept' => 'application/json','Content-Type' => 'application/text'};
            String responseJson = makeQuickBooksApiCall(url, 'POST', query, headers);
        handleResponseError(responseJson);
        QBProductJSON json = QBProductJSON.parse(responseJson);
        return json;
    }
    
    public QBProductResponseJSON createProductCall(Product2 product){
        String body = QBMap.mapProductData(product);
        QB_Metadata__mdt QBData = [SELECT Id, Base_Url__c, Company_Id__c, Minor_Version__c FROM QB_Metadata__mdt];
        String url = QBData.Base_Url__c + '/v3/company/' + QBData.Company_Id__c + '/item?minorversion=' + QBData.Minor_Version__c;
        Map<String, String> headers = new Map<String, String>{'Authorization' => 'Bearer ' + accessToken,'Accept' => 'application/json','Content-Type' => 'application/json'};
            String responseJson = makeQuickBooksApiCall(url, 'POST', body, headers);
        handleResponseError(responseJson);
        QBProductResponseJSON json = QBProductResponseJSON.parse(responseJson);
        return json;
    }

}