/**
 * Created By: Antonino Cupi
 * Date: 01/06/2018
 * Description: Create the POST request to retrieve the first token, this token will be expired in 10 minutes
**/
global class Post_TokenExpired {
    
    webservice static String setToken(){
        
        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:Token');
        req.setHeader('Content-Type','application/x-www-form-urlencoded');
        req.setHeader('Accept','application/vnd.api+json');
        req.setMethod('POST');
        req.setBody('grant_type=client_credentials&client_id=6&client_secret=QcFesbM4TvOw0qB4mmRkjJ2aOJV7MIS0kCrAbXdJ');
        Http http = new Http();
        HTTPResponse res = http.send(req);
        system.debug('*** body post token expired: '+res.getBody());
        
        Integer statuscode = res.getStatusCode();
        
        if(statusCode == 200 || statusCode == 201){
            Map<String, Object> m = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
            String token = String.valueof(m.get('access_token'));
            return token;
        } else {
            system.debug('*** statusCode: '+statusCode);
            return 'Error Token Expired';
        }
		
    }

}