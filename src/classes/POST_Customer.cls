/**
 * Created By: Antonino Cupi
 * Date: 01/06/2018
 * Description: Create the POST request in order to create a new customer in QC portal
**/
global class POST_Customer {
    
    webservice static String newCustomer(String name, String email,String token){
        
        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:Customer');
        req.setHeader('Content-Type','application/vnd.api+json');
        req.setHeader('Accept','application/vnd.api+json');
        req.setHeader('Authorization',token);
        req.setMethod('POST');
        req.setTimeout(2 * 60 * 1000);
        req.setBody('{"data": {"type": "customer","attributes": {"name": "'+name+'","notificationMail": "'+email+'","externalPlanCode": "SF_TRIAL","isTrial": true}}}');
        Http http = new Http();
        HTTPResponse res = http.send(req);
        system.debug('*** body post customer: '+res.getBody());
        
        Integer statuscode = res.getStatusCode();
        
        if(statusCode == 200 || statusCode == 201){
            return 'OK Customer';
        } else {
            system.debug('*** statusCode: '+statusCode);
            return res.getBody();
        }
		
    }

}