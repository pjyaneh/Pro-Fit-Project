trigger FindDuplicateTrigger on Event_Speaker__c (before insert, before update) {
    if(trigger.isBefore && (trigger.isInsert || trigger.isUpdate)){
        FindDuplicate.validateOverlappingEvent(Trigger.new);
    }
}