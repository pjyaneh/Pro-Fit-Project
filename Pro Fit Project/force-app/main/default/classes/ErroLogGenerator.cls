public with sharing class ErroLogGenerator {
public static void createErrorLog(String logDetails, String processName, DateTime logDateTime  ) {
    Error_Log__c err = new Error_Log__c();
    err.Log_Date_Time__c = logDateTime;
    err.Log_Details__c = logDetails;
    err.Name = processName;
    insert err;
}
}