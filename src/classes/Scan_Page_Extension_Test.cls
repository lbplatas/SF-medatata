@isTest
private class Scan_Page_Extension_Test {
    
    static testMethod void noCredentials(){
        
        Scan__c testScan = new Scan__c();
        insert testScan;
         
        ApexPages.StandardController sc = new ApexPages.StandardController(testScan);
        Scan_Page_Extension scanExtension = new Scan_Page_Extension(sc);
        
        PageReference pageRef = Page.Scan_Page;
        pageRef.getParameters().put('id', testScan.Id);
        Test.setCurrentPage(pageRef);
    
        scanExtension.checkCredential();
        
        // Assert Test
        List<Apexpages.Message> msgs = ApexPages.getMessages();
        boolean b = false;
        for(Apexpages.Message msg:msgs){
            if (msg.getDetail().contains('Please, enter Password and Security Token with no space (Ex. Password = "Hello" , Security Token = "World" --> "HelloWorld") :')) b = true;
        }
        System.assertNotEquals(0, msgs.size());
        //system.assert(b);
        
       // system.assertEquals(scanExtension.displayPopupPwdToken, true);
        system.assertEquals(scanExtension.instanceId, null);
        system.assertNotEquals(scanExtension.scans, null);
    }
    
    static testMethod void newCustomer(){
        
        Scan__c testScan = new Scan__c();
        insert testScan;
        
        Test.startTest();
        
        Test.setMock(HttpCalloutMock.class, new MockCallout_Test_PostCustomer()); 
        
        ApexPages.StandardController sc = new ApexPages.StandardController(testScan);
        Scan_Page_Extension scanExtension = new Scan_Page_Extension(sc);
        
        PageReference pageRef = Page.Scan_Page;
        pageRef.getParameters().put('id', testScan.Id);
        Test.setCurrentPage(pageRef);
    
        scanExtension.newCustomer();
        
        // Assert Test
        List<Apexpages.Message> msgs = ApexPages.getMessages();
        boolean b = false;
        for(Apexpages.Message msg:msgs){
            if (msg.getDetail().contains('Please, enter the credentials of the Quality Clouds user:')) b = true;
        }
        System.assertNotEquals(0, msgs.size());
        Test.stopTest();
        system.assert(b);
        system.assertEquals(scanExtension.displayPopupCredentialsQC, true);
        system.assertEquals(scanExtension.displayPopupPwdToken, null);
        system.assertEquals(scanExtension.instanceId, null);
        system.assertNotEquals(scanExtension.scans, null);
    }
    
    
    
    static testMethod void launchScan(){
        
        Scan__c testScan = new Scan__c();
        testScan.Status__c = 'SUCCESS';
        testScan.URL_Id__c = '207';
        testScan.LongId__c = 'testLongId';
        insert testScan;
        
        Test.startTest();
        
        Test.setMock(HttpCalloutMock.class, new MockCallout_Test_PostScan());
         
        ApexPages.StandardController sc = new ApexPages.StandardController(testScan);
        Scan_Page_Extension scanExtension = new Scan_Page_Extension(sc);
        
        PageReference pageRef = Page.Scan_Page;
        pageRef.getParameters().put('id', testScan.Id);
        Test.setCurrentPage(pageRef);
        
        scanExtension.checkCredential();
        scanExtension.launchScan();
        Test.stopTest();
        
        // Assert Test
        List<Apexpages.Message> msgs = ApexPages.getMessages();
       // System.assertEquals(0, msgs.size());
        
        List<Scan__c> listScans = [Select id,name,status__c,url_id__c from Scan__c];
       // system.assert(listScans.size() == 2);        
        system.assert(testScan.Id != null);
        system.assertNotEquals(scanExtension.instanceId, null);
        system.assertEquals(scanExtension.userCredentials, null);
        system.assertNotEquals(scanExtension.scans, null);
        system.assertEquals(scanExtension.displayPopupPwdToken, null);

    }
    
    static testMethod void launchFirstScan(){
        
        Scan__c testScan = new Scan__c();
        testScan.Status__c = 'SUCCESS';
        testScan.longID__C = 'test';
        insert testScan;
        
        Test.startTest();
        
        Test.setMock(HttpCalloutMock.class, new MockCallout_Test_PostInstance());
         
        ApexPages.StandardController sc = new ApexPages.StandardController(testScan);
        Scan_Page_Extension scanExtension = new Scan_Page_Extension(sc);
        
        PageReference pageRef = Page.Scan_Page;
        pageRef.getParameters().put('id', testScan.Id);
        Test.setCurrentPage(pageRef);

        scanExtension.userCredentials = 'passwordTokenTest';
        scanExtension.token = 'bearer test';
        scanExtension.newFirstScan();
        
        Test.stopTest();
        
        // Assert Test
        List<Apexpages.Message> msgs = ApexPages.getMessages();
        System.assertEquals(0, msgs.size());
        
        List<Scan__c> listScans = [Select id,name,status__c,url_id__c from Scan__c ];
        system.assert(listScans.size() == 2);        
        system.assert(testScan.Id != null);
        system.assertEquals(scanExtension.instanceId, null);
        system.assertNotEquals(scanExtension.userCredentials, null);
        system.assertNotEquals(scanExtension.scans, null);
        system.assertEquals(scanExtension.displayPopupPwdToken, false);
        
    }
    
    static testMethod void refresh(){
        
        Scan__c testScan = new Scan__c();
        testScan.Status__c = 'RUNNING';
        testScan.URL_Id__c = '207';
        insert testScan;
        
        Test.startTest();
        
        Test.setMock(HttpCalloutMock.class, new MockCallout_Test_PostScan());
         
        ApexPages.StandardController sc = new ApexPages.StandardController(testScan);
        Scan_Page_Extension scanExtension = new Scan_Page_Extension(sc);
        
        PageReference pageRef = Page.Scan_Page;
        pageRef.getParameters().put('id', testScan.Id);
        Test.setCurrentPage(pageRef);

        scanExtension.checkCredential();
        scanExtension.refresh();
        Test.stopTest();
        
        // Assert Test
        List<Apexpages.Message> msgs = ApexPages.getMessages();
        boolean b = false;
        for(Apexpages.Message msg:msgs){
            if (msg.getDetail().contains('Scan is in Running, please Refresh the page')) b = true;
        }
        System.assertNotEquals(0, msgs.size());
        
        List<Scan__c> listScans = [Select id,name,status__c,url_id__c from Scan__c ];
        system.assert(listScans.size() == 1);        
        system.assert(testScan.Id != null);
        system.assertNotEquals(scanExtension.instanceId, null);
        system.assertEquals(scanExtension.userCredentials, null);
        system.assertNotEquals(scanExtension.scans, null);
        system.assertEquals(scanExtension.displayPopupPwdToken, null);
        
    }
    
    static testMethod void errorPostInstance(){
        
        Scan__c testScan = new Scan__c();
        testScan.Status__c = 'SUCCESS';
        insert testScan;
        
        Test.startTest();
        
        Test.setMock(HttpCalloutMock.class, new MockCallout_Test_StatusCodeError());
         
        ApexPages.StandardController sc = new ApexPages.StandardController(testScan);
        Scan_Page_Extension scanExtension = new Scan_Page_Extension(sc);
        
        PageReference pageRef = Page.Scan_Page;
        pageRef.getParameters().put('id', testScan.Id);
        Test.setCurrentPage(pageRef);

        scanExtension.userCredentials = 'passwordTokenTest';
        scanExtension.token = 'bearer test';
        scanExtension.newFirstScan();
        
        Test.stopTest();
        
        // Assert Test
        List<Apexpages.Message> msgs = ApexPages.getMessages();
        boolean b = false;
        for(Apexpages.Message msg:msgs){
            if (msg.getDetail().contains('Please review Token org and Password, if the problem persist contact the admin.')) b = true;
        }
        System.assertNotEquals(0, msgs.size());
        
        List<Scan__c> listScans = [Select id,name,status__c,url_id__c from Scan__c ];
        system.assert(listScans.size() == 1);        
        system.assert(testScan.Id != null);
        system.assertEquals(scanExtension.instanceId, null);
        system.assertNotEquals(scanExtension.userCredentials, null);
        system.assertNotEquals(scanExtension.scans, null);
        system.assertEquals(scanExtension.displayPopupPwdToken, false);
        
    }
    
    static testMethod void errorPostScan(){
        
        Scan__c testScan = new Scan__c();
        testScan.Status__c = 'SUCCESS';
        testScan.URL_Id__c = '207';
        testScan.LongId__c = 'testLongId';
        insert testScan;
        
        Test.startTest();
        
        Test.setMock(HttpCalloutMock.class, new MockCallout_Test_StatusCodeError());
         
        ApexPages.StandardController sc = new ApexPages.StandardController(testScan);
        Scan_Page_Extension scanExtension = new Scan_Page_Extension(sc);
        
        PageReference pageRef = Page.Scan_Page;
        pageRef.getParameters().put('id', testScan.Id);
        Test.setCurrentPage(pageRef);
        
        scanExtension.checkCredential();
        Test.stopTest();
        
        // Assert Test
        List<Apexpages.Message> msgs = ApexPages.getMessages();
        boolean b = false;
        for(Apexpages.Message msg:msgs){
            if (msg.getDetail().contains('Internal Error, please contact the administrator.')) b = true;
        }
        System.assertNotEquals(0, msgs.size());
        
        List<Scan__c> listScans = [Select id,name,status__c,url_id__c from Scan__c ];
        system.assert(listScans.size() == 1);        
        system.assert(testScan.Id != null);
        system.assertNotEquals(scanExtension.instanceId, null);
        system.assertEquals(scanExtension.userCredentials, null);
        system.assertNotEquals(scanExtension.scans, null);
        system.assertEquals(scanExtension.displayPopupPwdToken, null);
        
    }
    
    static testMethod void firstScanNoPassword(){
        
        Scan__c testScan = new Scan__c();
        testScan.Status__c = 'SUCCESS';
        insert testScan;
        
        Test.startTest();
        
        Test.setMock(HttpCalloutMock.class, new MockCallout_Test_PostInstance());
         
        ApexPages.StandardController sc = new ApexPages.StandardController(testScan);
        Scan_Page_Extension scanExtension = new Scan_Page_Extension(sc);
        
        PageReference pageRef = Page.Scan_Page;
        pageRef.getParameters().put('id', testScan.Id);
        Test.setCurrentPage(pageRef);
        scanExtension.newFirstScan();
        
        Test.stopTest();
        
        // Assert Test
        List<Apexpages.Message> msgs = ApexPages.getMessages();
        boolean b = false;
        for(Apexpages.Message msg:msgs){
            if (msg.getDetail().contains('Please, enter Password and Security Token with no space (Ex. Password = "Hello" , Security Token = "World" --> "HelloWorld") :')) b = true;
        }
        System.assertNotEquals(0, msgs.size());
        
        List<Scan__c> listScans = [Select id,name,status__c,url_id__c from Scan__c ];
        system.assert(listScans.size() == 1);        
        system.assert(testScan.Id != null);
        system.assertEquals(scanExtension.instanceId, null);
        system.assertEquals(scanExtension.userCredentials, null);
        system.assertNotEquals(scanExtension.scans, null);
        system.assertEquals(scanExtension.displayPopupPwdToken, null);
        
    }
    
    static testMethod void noAdminUser(){
        
        Scan__c testScan = new Scan__c();
        insert testScan;
        
        String uniqueUserName = 'standarduser' + DateTime.now().getTime() + '@testorg.com';
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];
        User u = new User(Alias = 'standt', Email='standarduser@testorg.com',EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',LocaleSidKey='en_US', ProfileId = p.Id,TimeZoneSidKey='America/Los_Angeles',UserName=uniqueUserName);

        System.runAs(u) {
         
            ApexPages.StandardController sc = new ApexPages.StandardController(testScan);
            Scan_Page_Extension scanExtension = new Scan_Page_Extension(sc);
            
            PageReference pageRef = Page.Scan_Page;
            pageRef.getParameters().put('id', testScan.Id);
            Test.setCurrentPage(pageRef);
        
            scanExtension.checkCredential();
            
            // Assert Test
            List<Apexpages.Message> msgs = ApexPages.getMessages();
            boolean b = false;
            for(Apexpages.Message msg:msgs){
                if (msg.getDetail().contains('Permission insufficient! Please, contact your administrator to insert the credentials')) b = true;
            }
            System.assertNotEquals(0, msgs.size());
            
            system.assertEquals(scanExtension.instanceId, null);
            system.assertEquals(scanExtension.userCredentials, null);
            system.assertNotEquals(scanExtension.scans, null);
            system.assertEquals(scanExtension.displayPopupPwdToken, null);
        }
        List<Scan__c> listScans = [Select id,name,status__c,url_id__c from Scan__c ];
        system.assert(listScans.size() == 1);        
        system.assert(testScan.Id != null);
        
    }
    
}