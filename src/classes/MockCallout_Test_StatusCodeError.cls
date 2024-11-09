@isTest
global class MockCallout_Test_StatusCodeError implements HttpCalloutMock{
    
    global HTTPResponse respond(HTTPRequest req) {
        
       // System.assertEquals('callout:Post_Instance', req.getEndpoint());
       // System.assertEquals('POST', req.getMethod());
        
        HttpResponse res = new HttpResponse();
        
        res.setHeader('Content-Type', 'application/vnd.api+json');
        req.setHeader('Accept','application/vnd.api+json');
        req.setHeader('Authorization','bearer testTOken');
        res.setBody('{ "data":{  "attributes":{  "url":"login.salesforce.com","description":"testDescription","authToken":"passwordTokenTest","loginUrl":"login.salesforce.com","username":"username.test@test.com"}}}');
		res.setStatusCode(200);
        return res;
    }

}