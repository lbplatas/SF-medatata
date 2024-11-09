public class ClicData_Dashboards_Controller {
    
    public boolean showIframe;
    public boolean showErrorMessage;
    public Scan__c scan { get; set; }
    
    public ClicData_Dashboards_Controller(ApexPages.StandardController stdController) {
        
        try{
        	scan = [Select id,Status__c,URL_Id__c,Target__c from Scan__c  where Status__c ='SUCCESS' OR status__c = 'WARNING' LIMIT 1];    
        }  catch (exception e){
            scan = null;
        }
        
        
	}
    
    public boolean getShowIframe(){
        if(scan!=null){
            return true;
        }else{
            return false;
        }
    }
    
    public boolean getShowErrorMessage(){
        if(scan==null){
            return true;
        }else{
            return false;
        }
    }

}