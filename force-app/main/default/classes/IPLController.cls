public with sharing class IPLController {
    //Base Url Constant
    private static final String BASE_URL = 'https://raw.githubusercontent.com/karkranikhil/responses/main/';
    
    @AuraEnabled(cacheable=true)
    public static String fetchCricketData(String fileName){
        Http http = new Http();
        HttpRequest request = new HttpRequest();

        //set up the request

        request.setEndpoint(BASE_URL+fileName);
        request.setMethod('GET');

        try{
            // Send the HTTP request and get the response
            HttpResponse response = http.send(request);
            //check the response status code
            if(response.getStatusCode() == 200){
                return response.getBody();
            } else {
                String errorMessage = 'Failed to fetch data. HTTP Status is: '+response.getStatusCode();
                System.debug('Error:' + errorMessage);
                throw new AuraHandledException(errorMessage);
            }
        } catch(Exception e){
            //log any exception sthrown during the http request
            String errorMessage = 'Exception occurred while fetching data: '+e.getMessage();
            System.debug('Error:' + errorMessage);
            throw new AuraHandledException(errorMessage);
        }

    }
}