/**
 * Created By: Antonino Cupi
 * Date: 08/05/2018
 * Description: Delete the instance in QC when the first scan Fails
**/
global class Delete_Instance {
    
    webservice static String deleteInstance(String token,String instanceId){
        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:Instance'+'/'+instanceId);
        req.setHeader('Content-Type','application/vnd.api+json');
        req.setHeader('Accept','application/vnd.api+json');
        req.setHeader('Authorization',token);
        req.setMethod('DELETE');
        Http http = new Http();
        HTTPResponse res = http.send(req);
        system.debug('*** body delete instance: '+res.getBody());
        
        Integer statuscode = res.getStatusCode();
        
        if(statusCode == 200 || statusCode == 201 || statusCode == 202){
            return 'OK Delete Instance';
        } else {
            system.debug('*** statusCode: '+statusCode);
            return 'Error Delete Instance';
        }

	}
}