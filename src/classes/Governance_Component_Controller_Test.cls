@isTest
private class Governance_Component_Controller_Test {
    
    static testMethod void trendingIgual(){
        Scan__c testScan = new Scan__c();
        testScan.Status__c = 'SUCCESS';
        testScan.URL_Id__c = '207';
        testScan.Scan_date__c =datetime.newInstance(2014, 9, 15, 13, 30, 0);

        insert testScan;
        
        Scan__c testScan2 = new Scan__c();
        testScan2.Status__c = 'SUCCESS';
        testScan2.URL_Id__c = '207';
        testScan2.Scan_date__c =datetime.newInstance(2014, 9, 15, 12, 30, 0);

        insert testScan2;
        
        Test.startTest();
        
		PageReference pageRef = Page.Dashboard_Page;
        Test.setCurrentPage(pageRef);
        Governance_Component_Controller componentPage = new Governance_Component_Controller();
        
        Test.stopTest();
        
        //Assert Test
        List<Scan__c> listScans = [Select id,name,status__c,url_id__c from Scan__c ];
		system.assert(listScans.size() == 2);     
        system.assertEquals(componentPage.trendingIgual, true);
        system.assertEquals(componentPage.trendingDown, false);
        system.assertEquals(componentPage.trendingUp, false);
	}
    
    static testMethod void trendingUp(){
        Scan__c testScan = new Scan__c();
        testScan.Status__c = 'SUCCESS';
        testScan.URL_Id__c = '207';
        testScan.Scan_date__c =datetime.newInstance(2014, 9, 15, 13, 30, 0);
        testScan.Issues__c = 32;

        insert testScan;
        
        Scan__c testScan2 = new Scan__c();
        testScan2.Status__c = 'SUCCESS';
        testScan2.URL_Id__c = '207';
        testScan2.Scan_date__c =datetime.newInstance(2014, 9, 17, 12, 30, 0);
        testScan2.Issues__c = 45;

        insert testScan2;
        
        Test.startTest();
        
		PageReference pageRef = Page.Dashboard_Page;
        Test.setCurrentPage(pageRef);
        Governance_Component_Controller componentPage = new Governance_Component_Controller();
        
        Test.stopTest();
        
        //Assert Test
        List<Scan__c> listScans = [Select id,name,status__c,url_id__c from Scan__c ];
		system.assert(listScans.size() == 2);     
        system.assertEquals(componentPage.trendingIgual, false);
        system.assertEquals(componentPage.trendingDown, false);
        system.assertEquals(componentPage.trendingUp, true);
	}
    
    static testMethod void trendingDown(){
        Scan__c testScan = new Scan__c();
        testScan.Status__c = 'SUCCESS';
        testScan.URL_Id__c = '207';
        testScan.Scan_date__c =datetime.newInstance(2014, 9, 15, 13, 30, 0);
        testScan.Issues__c = 32;

        insert testScan;
        
        Scan__c testScan2 = new Scan__c();
        testScan2.Status__c = 'SUCCESS';
        testScan2.URL_Id__c = '207';
        testScan2.Scan_date__c =datetime.newInstance(2014, 9, 17, 12, 30, 0);
        testScan2.Issues__c = 23;

        insert testScan2;
        
        Test.startTest();
        
		PageReference pageRef = Page.Dashboard_Page;
        Test.setCurrentPage(pageRef);
        Governance_Component_Controller componentPage = new Governance_Component_Controller();
        
        Test.stopTest();
        
        //Assert Test
        List<Scan__c> listScans = [Select id,name,status__c,url_id__c from Scan__c ];
		system.assert(listScans.size() == 2);     
        system.assertEquals(componentPage.trendingIgual, false);
        system.assertEquals(componentPage.trendingDown, true);
        system.assertEquals(componentPage.trendingUp, false);
	}
    
    
    
}