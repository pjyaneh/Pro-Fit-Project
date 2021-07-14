@isTest
public with sharing class LocationTriggerHandler_Test {
    public static testMethod void testZip(){

        Address_Book__c loc = new Address_Book__c(
            Name = '3301 South Greenfield Rd',
            Street__c = '3301 South Greenfield Rd',
            City__c = 'Gilbert',
            State__c = 'AZ',
            Postal_Code__c = '85297',
            Country__c = 'United States of America'
        );
        insert loc;



        try{
            Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
            Test.startTest();

            LocationTriggerHandler.verifyZipCode(''+loc.Id+'');
            
            Test.stopTest();
        }catch(Exception ex){

        }
        Address_Book__c retrievedZipVerified = [Select Is_Zip_correct__c from Address_Book__c where Id =: loc.Id];
        System.assertEquals(true,retrievedZipVerified.Is_Zip_correct__c);

    }
    public static testMethod void testLoc(){
        Address_Book__c loc = new Address_Book__c(
            Name = '3301 South Greenfield Rd',
            Street__c = '3301 South Greenfield Rd',
            City__c = 'Gilbert',
            State__c = 'AZ',
            Postal_Code__c = '85297',
            Country__c = 'United States of America'
        );
        insert loc;

        try{
            Test.setMock(HttpCalloutMock.class, new LocationHttpMockResponse());
            Test.startTest();

            LocationTriggerHandler.locationCall(''+loc.Id+'');
            
            Test.stopTest();
        }catch(Exception ex){

        }
        Address_Book__c retrievedLocVerified = [Select Verified__c from Address_Book__c where Id =: loc.Id];
        System.assertEquals(true,retrievedLocVerified.Verified__c);
    }

}