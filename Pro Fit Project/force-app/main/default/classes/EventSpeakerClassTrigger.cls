public class EventSpeakerClassTrigger {
    
    
    public static void getNamesFromEventSpeaker(List<Event_Speaker__c> ESList)
    {
        try{
    
            Set<Id> eventId = new Set<Id>();
            Set<Id> eventSpeakerId = new Set<Id>();

            for(Event_Speaker__c evntSpkr : ESList){
                eventId.add(evntSpkr.Event__c);
                eventSpeakerId.add(evntSpkr.Speaker__c);
            }
       //     Map<Id,Event__c> eventSpeakerDate = [Select Start_Date_Time__c,End_Date_and_Time__c from Event__c where Id IN:eventId];
            
            Map<Id, DateTime> startrequestedEvents = new Map<Id, DateTime>();
            Map<Id, DateTime> endrequestedEvents = new Map<Id, DateTime>();



            List<Event__c> relatedEventList = [Select Id, Name,Start_Date_Time__c,End_Date_Time__c From Event__c 
            Where Id IN: eventId];


            for(Event__c evt : relatedEventList ){
                startrequestedEvents.put(evt.Id, evt.Start_Date_Time__c);
                endrequestedEvents.put(evt.Id, evt.End_Date_Time__c);
            
            }


            
            List<Event_Speaker__c> relatedEventSpeakerList = [ SELECT Id, Event__c, Speaker__c,Event__r.Start_Date_Time__c,Event__r.End_Date_Time__c From Event_Speaker__c
            WHERE Speaker__c IN : eventSpeakerId];



            
        for(Event_Speaker__c evntSpkr : ESList){

            DateTime startTime = startrequestedEvents.get(evntSpkr.Event__c);
            DateTime endTime = endrequestedEvents.get(evntSpkr.Event__c);


                for(Event_Speaker__c rS: relatedEventSpeakerList)
                {
                    if((rS.Event__r.Start_Date_Time__c < endTime && rS.Event__r.End_Date_Time__c > endTime)||(rS.Event__r.Start_Date_Time__c < startTime && rS.Event__r.End_Date_Time__c > startTime)||(rS.Event__r.Start_Date_Time__c >= startTime && rS.Event__r.End_Date_Time__c <= endTime))
                    {
                        evntSpkr.Speaker__c.addError('The Speaker has already an event!');
                    }

                }

           // Event__c eventDate = [Select Start_Date_Time__c,End_Date_and_Time__c from Event__c where Id = :evntSpkr.Event__c];



           /* List<Event_Speaker__c> eventSpeaker = [Select Id,Event__c,Speaker__c from Event_Speaker__c where Speaker__c = :evntSpkr.Speaker__c 
            
            AND((Event__r.Start_Date_Time__c <: eventDate.End_Date_and_Time__c

              AND Event__r.End_Date_and_Time__c >: eventDate.End_Date_and_Time__c) 

              OR(Event__r.Start_Date_Time__c <: eventDate.Start_Date_Time__c

               AND Event__r.End_Date_and_Time__c >: eventDate.Start_Date_Time__c)

               OR(Event__r.Start_Date_Time__c >= :eventDate.Start_Date_Time__c

               AND Event__r.End_Date_and_Time__c <= :eventDate.End_Date_and_Time__c))  ];  

            system.debug(''+eventDate);*/
              
            }
        }
            
            catch(Exception e){
                
              //  ErrorLogGenerator.createErrorLog(Datetime.now(),'Error on Event Speaker Trigger',e.toString());
                
            }
        }
    }