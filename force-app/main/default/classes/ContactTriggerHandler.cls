public class ContactTriggerHandler {
    @future(callout=true)
    public static void syncContacts(Set<Id> newContactIds) {
        QBSync_Controller.synchronizeContact(newContactIds);
    }
}