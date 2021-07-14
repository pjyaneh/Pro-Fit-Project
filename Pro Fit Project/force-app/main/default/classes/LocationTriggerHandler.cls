public class LocationTriggerHandler {
    
    @future(callout=true)
    public static void verifyZipCode(String recordId) {
        Address_Book__c locationRec = [Select Id, Name, Verified__c, Street__c, City__c, Postal_Code__c, State__c From Address_Book__c Where Id =: recordId];

        Http httpzip = new Http();
        HttpRequest reqzip = new HttpRequest();
        String addzip = 'https://us-zipcode.api.smartystreets.com/lookup?auth-id=e03752e6-8e24-add8-434c-2dfd5950cc71&auth-token=MhaVbFlEUsQpmvnAyQ3k&city=&state=&zipcode='+ +locationRec.Postal_Code__c;
        reqzip.setEndPoint(addzip);
        reqzip.setMethod('GET');
        HttpResponse respzip= new HttpResponse();
        respzip = httpzip.send(reqzip);
        System.debug(respzip.getBody());
        System.debug(locationRec.Postal_Code__c);
        System.debug(respzip.getStatusCode());
        try {
            if(respzip.getStatusCode() == 200){
                List<Object> resultsZipList = (List<Object>)JSON.deserializeUntyped(respzip.getBody());
                    for(Object obj : resultsZipList){
                        Map<String, Object> results = (Map<String, Object>) obj;
                        List<Object> zipObject = (List<Object>) results.get('zipcodes');
                        if(zipObject!=null){
                            locationCall(recordId);
                        }
                    }
                
                }
        } 
        
        catch (Exception ex) {
            System.debug('Exception -- ' + ex.getMessage());
        }
    }



    public static void locationCall(String recordId){
        Address_Book__c loc = [Select Id,Is_Zip_Correct__c,State__c,Street__c,Postal_Code__c,City__c from Address_Book__c where Id = :recordId];
        Http httpst = new Http();
        HttpRequest reqst = new HttpRequest();
         String addst = 'https://us-street.api.smartystreets.com/street-address?auth-id=e03752e6-8e24-add8-434c-2dfd5950cc71&auth-token=MhaVbFlEUsQpmvnAyQ3k&'
         +'street=' + EncodingUtil.urlEncode(loc.Street__c, 'UTF-8') 
         +'&city='+ EncodingUtil.urlEncode(loc.City__c, 'UTF-8')
         +'&state='+EncodingUtil.urlEncode(loc.State__c, 'UTF-8');
         reqst.setEndPoint(addst);
         reqst.setMethod('GET');
        HttpResponse respst= new HttpResponse();
        respst = httpst.send(reqst); 
        try {
            
            if(respst.getStatusCode() == 200){
                String respstBody = respst.getBody();
                    if(respstBody.length()>2){
                        loc.Is_Zip_Correct__c = true;
                        loc.Verified__c = true;
                    }else{
                        loc.Is_Zip_Correct__c = false;
                        loc.Verified__c = false;
                    }
                    update loc;
            }
        } 
        catch (Exception ex) {
            System.debug('Exception -- ' + ex.getMessage());
        }
    }
}