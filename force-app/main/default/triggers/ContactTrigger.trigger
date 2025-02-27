trigger ContactTrigger on Contact (after insert, after update) {
    if(trigger.isAfter && (trigger.isInsert || trigger.isUpdate)){
        Set<Id> contactIds = new Set<Id>();
        for(Contact con : trigger.new){
            if(System.IsBatch() == false && System.isFuture() == false){ 
                contactIds.add(con.Id);
            }
        }
        if (!contactIds.isEmpty()) {
            ContactTriggerHandler.syncContacts(contactIds);
        }
    }
}