/**
 * Created By: Antonino Cupi
 * Date: 06/04/2018
 * Description: Create the POST request for a new scan in the instance
**/
global class POST_Scan {
    
    webservice static String setScan(String token, String instanceId){
    
        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:Scan');
        req.setHeader('Content-Type','application/vnd.api+json');
        req.setHeader('Accept','application/vnd.api+json');
        req.setHeader('Authorization',token);
        req.setMethod('POST');
        req.setBody('{"data": {"type": "scan","attributes": {"urlId":'+instanceId+',"scanType": 0}}}');
        Http http = new Http();
        HTTPResponse res = http.send(req);
        system.debug('*** body post scan: '+res.getBody());
        Integer statuscode = res.getStatusCode();
        
        if(statusCode == 201 || statusCode == 202){
            Map<String, Object> m = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
            Map<String, Object> data = (Map<String, Object>)m.get('data');
            String scan_id = String.valueof(data.get('id'));
            return scan_id;
        } else {
            system.debug('*** statusCode: '+statusCode);
            return 'Error';
        }
       
    }

}