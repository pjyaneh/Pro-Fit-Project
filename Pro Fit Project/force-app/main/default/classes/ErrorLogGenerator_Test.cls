@isTest
public with sharing class ErrorLogGenerator_Test {
    @IsTest
    static void testError(){

        Test.startTest();
        DateTime logDate = datetime.newInstance(2021, 6, 21, 19, 30, 0);
        String logDetails = 'Error Test';
        String name = 'Test Error Name';
        ErroLogGenerator.createErrorLog(logDetails, name, logDate);

        Test.stopTest();
        Error_Log__c eLog = [Select Id, Log_Date_Time__c,Log_Details__c,Name from Error_Log__c];
        System.assertEquals('Test Error Name', eLog.Name);
    }
}