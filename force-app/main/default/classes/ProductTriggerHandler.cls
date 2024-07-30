public class ProductTriggerHandler {
	@future(callout=true)
    public static void syncProduct(Id prodId) {
        Product2 prod = [SELECT Id, Name, ProductCode, Description, IsActive, Type, QBO_SyncToken__c, QBO_Id__c FROM Product2 Where Id =: prodId];

        QBSync_Controller.synchronizeProduct(prod);
    }
}