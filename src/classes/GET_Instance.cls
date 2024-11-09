/**
 * Created By: Antonino Cupi
 * Date: 09/05/2018
 * Description: Get the list of instance already set in the QC portal by the user
**/
global class GET_Instance {
    
    webservice static String getInstance(String token){
        
        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:Instance');
        req.setHeader('Content-Type','application/vnd.api+json');
        req.setHeader('Accept','application/vnd.api+json');
        req.setHeader('Authorization',token);
        req.setMethod('GET');
        Http http = new Http();
        HTTPResponse res = http.send(req);
        system.debug('*** body get instance: '+res.getBody());
        String body = res.getBody();
        Integer statuscode = res.getStatusCode();
        
        if(statusCode == 200 || statusCode == 201 || statusCode == 202){
            return body;
        } else {
            system.debug('*** statusCode: '+statusCode);
            return null;
        }
        
	}
    
   
}