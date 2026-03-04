public with sharing class IPLController {
    // Base Url Constant
    private static final string BASE_URL = 'https://raw.githubusercontent.com/karkranikhil/responses/main';

    @AuraEnabled(cacheable = true)
    public static String fetchCricketData(String fileName){
        Http http = new Http();
        HttpRequest request = new HttpRequest();

        //set up the request
        request.setEndPoint(BASE_URL + fileName);
        request.setMethod('GET');

        try{
            HttpResponse response = http.send(request);
            if(response.getStatusCode() == 200){
                return response.getBody();
            }else{
                String errorMessage = 'Failed to fetch data. Http Status is : ' + response.getStatusCode();
                System.debug('Error : '+ errorMessage);
                throw new AuraHandledException(errorMessage);
            }
        }catch(Exception e){
            //log any exceptions thrown during the http request
            String errorMessage = 'Error occured while fetching data : ' + e.getMessage();
            System.debug('Error : '+ errorMessage);
            throw new AuraHandledException(errorMessage);
        }
    }
}