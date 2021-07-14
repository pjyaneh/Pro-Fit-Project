@isTest
public with sharing class FindDuplicate_Test {
    
    Static Id createTestRecordIEventOrganizer(){
        Event_Organizer__c eventOrganizer = new Event_Organizer__c();
        eventOrganizer.Name = 'Premfort Jernan';
        eventOrganizer.Phone__c = '092311993';
        eventOrganizer.Email__c = 'premfort.jernan@gmail.com';
        eventOrganizer.Alternative_Phone__c  = '09484732696';
        eventOrganizer.Alternative_Email__c ='jernan.premfort@gmail.com';      
        insert eventOrganizer;
        return eventOrganizer.Id;
}
    Static Id createTestRecordIEventOrganizer2(){
      Event_Organizer__c eventOrganizer2 = new Event_Organizer__c();
      eventOrganizer2.Name = 'Premfort Jernan2';
      eventOrganizer2.Phone__c = '092311993';
      eventOrganizer2.Email__c = 'premfort.jernan@gmail.com';
      eventOrganizer2.Alternative_Phone__c  = '09484732696';
      eventOrganizer2.Alternative_Email__c ='jernan.premfort@gmail.com';      
      insert eventOrganizer2;
      return eventOrganizer2.Id;
    }
      
    Static Id createTestRecordID(){

        Event__c evt = new Event__c();
        evt.Name__c = 'Test Event';
        evt.Live__c = true;
        evt.Status__c = 'Created';
        evt.Event_Organizer__c = createTestRecordIEventOrganizer();
        evt.Start_Date_Time__c = datetime.newInstance(2021, 8, 21, 19, 30, 0);
        evt.End_Date_Time__c = datetime.newInstance(2021, 8, 22, 20, 30, 0);
        insert evt;
        return evt.Id;
       
    }

    Static Id createTestRecordSpeakerID(){

      Speaker__c spk = new Speaker__c();
      spk.Name = 'Test Speaker';
      spk.Email__c = 'premfort.jernan@gmail.com';
      spk.Phone__c  = '09484732696';
      insert spk;
      return spk.Id;
     
  }
  Static Id createTestRecordSpeakerID2(){

    Speaker__c spk2 = new Speaker__c();
    spk2.Name = 'Test Speaker';
    spk2.Email__c = 'premfort.jernan@gmail.com';
    spk2.Phone__c  = '09484732696';
    insert spk2;
    return spk2.Id;
   
}

        @IsTest
      Static void checkEventEspeaker(){
        Test.startTest();

        
        Event_Speaker__c eS = new Event_Speaker__c();
        eS.Name = 'Test Event-Speaker';
        eS.Event__c = createTestRecordID();
        eS.Speaker__c = createTestRecordSpeakerID();
        
        insert eS;
        Test.stopTest();

        Event_Speaker__c retrievedES = [Select Name from Event_Speaker__c where Name =: eS.Name];

        System.assertEquals('Test Event-Speaker',retrievedES.Name);
          
      }

    
}