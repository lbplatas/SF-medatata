/**
 * Created By: Antonino Cupi
 * Date: 06/04/2018
 * Description: Create the POST request to create the Instance in QC server (It will be called only the first time)
**/
global class POST_Instance {
    
    webservice static String setOrg(String token, String userCredentials, String url, String username, String loginUrl,String description){
        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:Instance');
        req.setHeader('Content-Type','application/vnd.api+json');
        req.setHeader('Accept','application/vnd.api+json');
        req.setHeader('Authorization',token);
        req.setMethod('POST');
        req.setBody('{ "data":{  "attributes":{  "url":"'+url+'","description":"' +description+'","authToken":"' +userCredentials+'","loginUrl":"'+loginUrl+'","username":"'+username+'"}}}');
        Http http = new Http();
        HTTPResponse res = http.send(req);
        system.debug('*** body post instance: '+res.getBody());
        
        Integer statuscode = res.getStatusCode();
        
        if(statusCode == 201){
            Map<String, Object> m = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
            Map<String, Object> data = (Map<String, Object>)m.get('data');
            String instanceId = String.valueof(data.get('id'));
            return instanceId;
        } else {
            system.debug('*** statusCode: '+statusCode);
            return 'Error';
        }
       
    }

}