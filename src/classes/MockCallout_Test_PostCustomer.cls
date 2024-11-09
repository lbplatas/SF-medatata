@isTest
global class MockCallout_Test_PostCustomer implements HttpCalloutMock{
    
    global HTTPResponse respond(HTTPRequest req) {
        
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{"data": {"type": "customer","attributes": {"name": "SF App Customer","notificationMail": "user@email.com","externalPlanCode": "SF_TRIAL","isTrial": true}}}');
        res.setStatusCode(201);
        return res;
    }

}