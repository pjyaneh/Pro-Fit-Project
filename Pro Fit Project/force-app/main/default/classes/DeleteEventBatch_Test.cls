@isTest
public class DeleteEventBatch_Test {

   @TestSetup
   static void testSetupData(){
       Event_Organizer__c eventOrganizer = new Event_Organizer__c(
       Name = 'Premfort Jernan',
       Phone__c = '092311993',
       Email__c = 'premfort.jernan@gmail.com',
       Alternative_Phone__c  = '09484732696',
       Alternative_Email__c ='jernan.premfort@gmail.com'
       );
       insert eventOrganizer;

       List<Event__c> eventList = new List<Event__c>();
      
           Event__c event = new Event__c(
               Name__c = 'Test Event',
               Event_Organizer__c  = eventOrganizer.Id,
               Event_Type__c = 'Virtual',
               Frequency__c  = 'Weekly',
     
               Status__c = 'Completed',
               Recurring__c = true,
               Live__c = true,
               Start_Date_Time__c = datetime.newInstance(2021,1,1,9,0,0),
               End_Date_Time__c  = datetime.newInstance(2021,1,2,9,0,0)
           );
       eventList.add(event);
       insert eventList;
   }
  
   @isTest
   static void sendDeletEventTest(){
       Test.startTest();

       Database.executeBatch(new DeleteEventBatch());
       
       Test.stopTest();
       Event__c eventCreated = [Select Id, Name, Status__c from Event__c where id=: event.Id];
       System.assertEquals('Deleted', eventCreated.Status__c );
       
 
       
   }
}