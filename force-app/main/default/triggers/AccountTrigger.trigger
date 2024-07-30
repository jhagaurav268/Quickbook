trigger AccountTrigger on Account (after insert, after update) {
    if(trigger.isAfter && (trigger.isInsert || trigger.isUpdate)){
        for(Account acc : trigger.new){
            if(System.IsBatch() == false && System.isFuture() == false){ 
                AccountTriggerHandler.syncAccount(acc.Id);
            }
        }
    }
}