public class AccountTriggerHandler {
	@future(callout=true)
    public static void syncAccount(Id accId) {
        Account acc = [SELECT Id, Name, QBO_Id__c, QBO_SyncToken__c FROM Account WHERE Id =: accId];
        QBSync_Controller.synchronizeAccount(acc);
    }
}