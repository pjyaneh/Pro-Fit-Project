@isTest
public with sharing class EventDetailsController_Test {
    
    static Id createTestEvent(){
        Event__c evt = new Event__c();
        evt.Name__c = 'Test Event';
        evt.Status__c = 'Created';
        evt.Start_Date_Time__c = datetime.newInstance(2021,7,1,9,0,0);
        evt.End_Date_Time__c  = datetime.newInstance(2021,7,2,9,0,0);
        evt.Live__c = true;
        evt.Seat__c = 100;
        insert evt;
        return evt.Id;
    }
    static Id createTestSpeaker(){
        Speaker__c spk = new Speaker__c();
        spk.Name = 'Test Spek';
        spk.Email__c = 'testmail@gmail.com';
        spk.Phone__c = '1201003011';
        insert spk;
        return spk.Id;
    }
    static Id createTestAttendee(){
        Attendee__c att = new Attendee__c();
        att.Name = 'Test Attendee';
        att.Email__c = 'testmail@gmail.com';
        att.Phone__c = '123123213';
        insert att;
        return att.Id;
    }
    @IsTest
    static void testSpeaker(){
        
        Test.startTest();
        String recId;
        Event_Speaker__c eS = new Event_Speaker__c();
        eS.Event__c = createTestEvent();
        eS.Speaker__c = createTestSpeaker();
        eS.Name = 'Test Name';
        Event_Speaker__c name;
        String str = '';
        insert eS;
        List<Event_Speaker__c> retrievedSpeaker = EventDetailsController.getSpeakers(eS.Event__c);
        name = retrievedSpeaker.get(0);
        Test.stopTest();
        System.assertEquals('Test Name',name.Name);
    }
    @IsTest
    static void testLocation(){
        Test.startTest();
        String recId = createTestEvent();
        Event__c evts = EventDetailsController.getLocationDetails(recId);
        
        Test.stopTest();
        System.assertEquals('Test Event',evts.Name__c);
    }
    @isTest
    static void testAttendee(){
        Test.startTest();
        Event_Attendee__c eA = new Event_Attendee__c();
        eA.Attendee__c = createTestAttendee();
        eA.Event__c = createTestEvent();

        insert eA;
        Event_Attendee__c name;
        List<Event_Attendee__c> retrievedAttendee = EventDetailsController.getAttendees(eA.Event__c);
        name = retrievedAttendee.get(0);
        
        Test.stopTest();
        System.assertEquals('Test EA', name.Name);
    }
}