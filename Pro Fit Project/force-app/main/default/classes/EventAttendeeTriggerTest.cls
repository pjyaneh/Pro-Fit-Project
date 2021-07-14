@isTest
public class EventAttendeeTriggerTest {
	
    @testSetup
    public static void setupData(){
        
        Event_Organizer__c  org = new Event_Organizer__c (
            Name = 'Test Organizer',
            Phone__c = '101010101',
            Email__c = 'jernan.premfort@gmail.com',
            Alternative_Phone__c  = '1111111',
            Alternative_Email__c ='premfort.jernan1@gmail.com'
        );
        insert org;
        
        Event__c event = new Event__c(
            Name__c = 'Pro Fit Test Event',
            Event_Organizer__c  = org.Id,
            Event_Type__c = 'Virtual',
            Frequency__c  = 'Weekly',
            Status__c = 'Published',
           	Seat__c  = 199,
            Recurring__c = true,
            Live__c = true,
            Start_Date_Time__c = System.now(),
            End_Date_Time__c  = System.now().addDays(3)
        );
        insert event;
        Attendee__c att = new Attendee__c(
            Name = 'Premfort jernan',
            Email__c = 'premfort.jernan@gmail.com',
            Phone__c = '1111111'
        );
        insert att;
        
        Event_Attendee__c evtAtt = new Event_Attendee__c(Event__c = event.Id, Attendee__c = att.Id);
        insert evtAtt;
    }
    
    @isTest
    static void sendEmailTest(){
        Test.startTest();
        
       List<Event_Attendee__c> evtAtt = [Select Id, Name, Attendee__c, Event__c from Event_Attendee__c];
       EventAttendeeTriggerHandler.sendConfirmationEmail(evtAtt);
       Integer invocations = Limits.getEmailInvocations();
        Test.stopTest();
        System.assertEquals(0,invocations);
    }
}