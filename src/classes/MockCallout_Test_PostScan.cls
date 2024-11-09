@isTest
global class MockCallout_Test_PostScan implements HttpCalloutMock{
    
    global HTTPResponse respond(HTTPRequest req) {
        
        //System.assertEquals('callout:Post_Scan', req.getEndpoint());
        //System.assertEquals('POST', req.getMethod());
        
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{"data": {"type": "scan","attributes": {"urlId":"207","scanType": 0, "technical-debt":"123","process-time":"123","quality-of-cloud":"50","changes-issues-ratio":"50","code-changes-issues-ratio":"50","scan-date": "2018-04-12 17:30:18" }}}');
        res.setStatusCode(201);
        return res;
    }

}