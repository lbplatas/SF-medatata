/**
 * Created By: Antonino Cupi
 * Date: 06/04/2018
 * Description: Create the GET request of the new scan in order to pass the infos of the new scan to the class "Insert_Scan"
**/
global class GET_Scan {
    
    webservice static void getScan(String token, String scan_id, String instanceId){
        
        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:Scan/'+scan_id);
        req.setHeader('Content-Type','application/vnd.api+json');
        req.setHeader('Accept','application/vnd.api+json');
        req.setHeader('Authorization',token);
        req.setMethod('GET');
        Http http = new Http();
        HTTPResponse res = http.send(req);
        system.debug('*** body get scan: '+res.getBody());
        
        Integer statuscode = res.getStatusCode();
        
        if(statusCode == 200 || statusCode == 201 || statusCode == 202){
            Map<String, Object> m = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
            Map<String, Object> data = (Map<String, Object>)m.get('data');
            Map<String, Object> att = (Map<String, Object>)data.get('attributes');
            String statusScan = String.valueof(att.get('status'));
            Insert_Scan.retrieveInfo(statusScan, res.getBody(), scan_id,instanceId);
        } else {
            system.debug('*** statusCode: '+statusCode);
            
        }
        
	}
    
   
}