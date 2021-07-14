public class DeleteEventBatch implements Database.Batchable<sObject> {
    
    public Database.QueryLocator start(Database.BatchableContext batchContext){
        String Query = 'Select Id, Name From Event__c Where  Status__c != \'Complete\' AND End_Date_Time__c < LAST_N_MONTHS:4';
        return Database.getQueryLocator(Query);
    }
    

    public void execute(Database.BatchableContext batchContext, List<Event__c> eventList ){

        List<Event__c> deletedEvtRecsList = new List<Event__c>();
        for(Event__c evt: eventList){
            evt.Status__c = 'Deleted';
            deletedEvtRecsList.add(evt);
            
        }
        update deletedEvtRecsList;
    }
    
    public void finish(Database.BatchableContext batchContext){

        String userName = UserInfo.getUserName();
        User activeUser = [Select Email,Name From User where Username = : userName limit 1];
        String userEmail = activeUser.Email;
        String displayName = activeUser.Name;
        System.debug('users email: '+userEmail);

        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        
        mail.setSubject('Batch Processing Completed');
        List<String> toAddress = new List<String>();
        toAddress.add(userEmail);
        mail.setToAddresses( toAddress );   
        mail.setSenderDisplayName(displayName);
        
        mail.setHtmlBody('The DeleteEventBatch Batch Prcoessing has been Completed');
        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage> {mail};
        Messaging.sendEmail(emails);
    }
}