@isTest
private class Dashboard_Controller_Test {
    
    static testMethod void controller(){
        Scan__c testScan = new Scan__c();
        testScan.Status__c = 'SUCCESS';
        testScan.URL_Id__c = '207';
        testScan.Scan_date__c =datetime.newInstance(2014, 9, 15, 13, 30, 0);

        insert testScan;
        
        Test.startTest();
        
        Dashboard_Controller dashboardPage = new Dashboard_Controller();
        
        PageReference pageRef = Page.Dashboard_Page;
        Test.setCurrentPage(pageRef);
        dashboardPage.getData();
        
        Test.stopTest();
        
        //Assert Test
        List<Scan__c> listScans = [Select id,name,status__c,url_id__c from Scan__c ];
		system.assert(listScans.size() == 1);        
        system.assert(testScan.Id != null);
        system.assertEquals(dashboardPage.displayError, null);
        system.assertNotEquals(dashboardPage.getData(), null);
	}
    
    static testMethod void componentTrue(){
        Scan__c testScan = new Scan__c();
        testScan.Status__c = 'SUCCESS';
        testScan.URL_Id__c = '207';
        testScan.Scan_date__c =datetime.newInstance(2014, 9, 15, 13, 30, 0);

        insert testScan;
        
        Test.startTest();
        
        Dashboard_Controller dashboardPage = new Dashboard_Controller();
        
        PageReference pageRef = Page.Dashboard_Page;
        Test.setCurrentPage(pageRef);
        dashboardPage.getDisplayError();
        
        Test.stopTest();
        
        //Assert Test
        List<Scan__c> listScans = [Select id,name,status__c,url_id__c from Scan__c ];
		system.assert(listScans.size() == 1);        
        system.assert(testScan.Id != null);
        system.assertEquals(dashboardPage.getDisplayError(), false);
	}
    
    static testMethod void componentFalse(){
        
        Test.startTest();
        
        Dashboard_Controller dashboardPage = new Dashboard_Controller();
        
        PageReference pageRef = Page.Dashboard_Page;
        Test.setCurrentPage(pageRef);
        dashboardPage.getDisplayError();
        
        Test.stopTest();
        
        //Assert Test
        List<Scan__c> listScans = [Select id,name,status__c,url_id__c from Scan__c ];
		system.assert(listScans.size() == 0);     
        system.assertEquals(dashboardPage.getDisplayError(), true);
	}
}