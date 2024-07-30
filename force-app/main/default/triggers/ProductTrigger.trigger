trigger ProductTrigger on Product2 (after insert, after update) {
    if(trigger.isAfter && (trigger.isInsert || trigger.isUpdate)){
        for(Product2 prod : trigger.new){
            if(System.IsBatch() == false && System.isFuture() == false){ 
                ProductTriggerHandler.syncProduct(prod.Id);
            }
        }
    }
}