public with sharing class EventDetailsController {
    @AuraEnabled
    public static List<Event_Speaker__c> getSpeakers(String eventId) {
      List<Event_Speaker__c> speakerList = [Select Id,Name,Speaker__c,Speaker__r.Name,Speaker__r.Phone__c,Speaker__r.Email__c,Speaker__r.Company__c from Event_Speaker__c where Event__c = :eventId];
      return speakerList;
    }
  
    @AuraEnabled
    public static Event__c getLocationDetails(String eventId) {
      Event__c eventRecord = [Select Id, Name__c, Location__c, Location__r.Name, Location__r.City__c, Location__r.Country__c, Location__r.Landmark__c, Location__r.Postal_Code__c, Location__r.State__c, Location__r.Street__c from Event__c where Id = :eventId];
      return eventRecord;
    }
  
    @AuraEnabled
    public static List<Event_Attendee__c> getAttendees(String eventId) {
      List<Event_Attendee__c> eventAttendeeList = [Select Id, Name, Attendee__c, Attendee__r.Name, Attendee__r.Email__c, Attendee__r.Company__c, Attendee__r.Location__c, Attendee__r.Location__r.Name from Event_Attendee__c where Event__c = :eventId];
      return eventAttendeeList;
    }
  }