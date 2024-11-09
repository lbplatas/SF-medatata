/**
 * Created By: Antonino Cupi
 * Date: 06/04/2018
 * Description: Controller of the Visualforce "Scan_Page"
**/
public class Scan_Page_Extension {
    
    private final Id scanId;
    public List<Scan__c> scans { get; set; }
    public boolean displayPopupPwdToken { get; set; }
    public boolean displayPopupCredentialsQC { get; set; }
    public boolean displayLaunchScan { get; set; }
    public boolean displayCreateCustomer { get; set; }
	public String userCredentials { get; set; }
    public String token { get; set; }
    public String instanceId { get; set; }
    public String passwordQC { get; set; }
    public String usernameQC { get; set; }
    public String nameCustomer { get; set; }
    public String emailCustomer { get; set; }
    public String tokenExpired { get; set; }
 
    public Scan_Page_Extension(ApexPages.StandardController stdController) {
        
        this.displayLaunchScan = false;
        
        scans = [Select id, name, Scan_Date__c,Status__c, Issues__c, Technical_Debt__c, Code_Lines__c,URL_Id__c,longID__C from Scan__c  order by Scan_Date__c DESC];
        
        for(Scan__c sc : scans){
            if(sc.Status__c == 'SUCCESS' || sc.Status__c == 'WARNING' || sc.Status__c == 'RUNNING'){
                this.displayLaunchScan = true;
                break;
            }
        }
	}
    
    public void newCustomer() {
        
        String post_Token = Post_TokenExpired.setToken();
        this.tokenExpired = 'Bearer ' + post_Token;
        
        if(this.tokenExpired != 'Bearer Error Token Expired'){
        	String customer = POST_Customer.newCustomer(nameCustomer,emailCustomer,tokenExpired);
            if(customer == 'OK Customer'){
                Insert_Token customerOk = new Insert_Token();
            	customerOk.insertToken(customer);
                this.displayCreateCustomer = false;
                this.displayPopupCredentialsQC=true;
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Please, enter the credentials of the Quality Clouds user:'));
            } else {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Internal Error'+customer+', contact the support:'));
            }
        }
        
    }
    
    public void backUser() {
        this.displayCreateCustomer = true;
        this.displayPopupCredentialsQC=false;
    }
    
    public void checkCredential() {
        
        List<String> scansRunningId = new List<String>();
        for(Scan__c sc : scans){
            if(sc.Status__c == 'RUNNING'){
                scansRunningId.add(sc.longID__C);
            }
        }
        if(!scansRunningId.isEmpty()){
        	ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Scan is in Running, please click on the button Refresh'));
        } else{
        	String pname = [Select Name from Profile where Id =: userinfo.getProfileid()].name;
            if(pname!='System Administrator'){
            	ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Permission insufficient! Please, contact your administrator'));
            } else {
                getTokenPassword();
                if (token == '-'){
                   ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Please, insert name and email for the new User in QC:'));
                   this.displayCreateCustomer = true;
                } else if (token == 'Bearer OK Customer') {
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Please, enter the credentials of the Quality Clouds user:'));
                    this.displayPopupCredentialsQC = true;
                    this.displayCreateCustomer = false;
                } else {
               		if(instanceId==null){
                    	this.displayPopupPwdToken = true;
                    	ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Please, enter Password and Security Token with no space (Ex. Password = "Hello" , Security Token = "World" --> "HelloWorld") :'));
                   	} else {
                        this.displayLaunchScan = true;
                        ApexPages.addmessage(new ApexPages.message(ApexPages.Severity.CONFIRM,'Your instance is already installed! Launch your first scan!'));
               		}
                }    
            }
        }
    }
    
    public void launchScan() {
        
        List<String> scansRunningId = new List<String>();
        for(Scan__c sc : scans){
            if(sc.Status__c == 'RUNNING'){
                scansRunningId.add(sc.longID__C);
            }
        }
        if(!scansRunningId.isEmpty()){
        	ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Scan is in Running, please click on the button Refresh'));
        } else{
        	String pname = [Select Name from Profile where Id =: userinfo.getProfileid()].name;
            if(pname!='System Administrator'){
            	ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Permission insufficient! Please, contact your administrator'));
            } else {
                getTokenPassword();
                newScan(instanceId);
            }
        }
    }
    
    public void checkInstance(){
        String listInstances = GET_Instance.getInstance(token);
        Boolean instanceExisting = false;
        String orgId = UserInfo.getOrganizationId();
        String username = UserInfo.getUserName();
        
        if(listInstances != null && listInstances != ''){
            
            Map<String, Object> m = (Map<String, Object>) JSON.deserializeUntyped(listInstances);
            List<Map<String, Object>> data = new List<Map<String, Object>>();
            for (Object d : (List<Object>)m.get('data')){
            	data.add((Map<String, Object>)d);   
            }
            for(Map<String, Object> d : data){
                Map<String, Object> att = (Map<String, Object>)d.get('attributes');
                String usernameInstance = String.valueof(att.get('username'));
                String pwd = String.valueof(att.get('auth-token'));
                if(this.userCredentials==pwd && username==usernameInstance){
                    instanceExisting = true;
                    this.instanceId = String.valueof(d.get('id'));
                }
            }
        }
        if(instanceExisting == true){
            this.displayPopupPwdToken = false;
            this.displayLaunchScan = true;
            newScan(this.instanceId);
        }else{
            newFirstScan();
        }
    }
    
    
	public void newFirstScan() {
        
        if(string.isBlank(userCredentials)){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Please, enter Password and Security Token with no space (Ex. Password = "Hello" , Security Token = "World" --> "HelloWorld") :'));
        } else {
            
        	this.displayPopupPwdToken = false; 
            
            boolean okDelete = false;
            String instanceIdDelete;
            DateTime scanDate = null;
            for(Scan__c sc : scans){
            	if(sc.Status__c == 'FAIL'){
                    okDelete = true;
                    if(scanDate == null){
                    	instanceIdDelete = sc.URL_Id__c;
                    	scanDate = sc.Scan_Date__c;
                    }
                    if(sc.Scan_Date__c > scanDate){
                        instanceIdDelete = sc.URL_Id__c;
                    }
                }
            }
            
            if (okDelete == true){
                Delete_Instance.deleteInstance(token,instanceIdDelete);
            }
                
            String url = System.URL.getSalesforceBaseUrl().getHost();
            url = 'https://'+ url.substring(2,6) + 'salesforce.com';
            String username = UserInfo.getUserName();
            String loginUrl;
            String description;
            Boolean isSandbox =  runningInASandbox();
            if(isSandbox == true){
                loginUrl = 'test.salesforce.com';
                description = 'DEV';
            } else {
                loginUrl = 'login.salesforce.com';
                description = 'PROD';
            }
            
            String instId = POST_Instance.setOrg(token,userCredentials,url,username,loginUrl,description);
            if(instId == 'Error'){
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Please review Token org and Password, if the problem persist contact the admin.'));
            } else {
                newScan(instId);
            }
        }
    }
    
    public void newScan(String instanceId) {
        
        String scan_id;
        scan_id = POST_Scan.setScan(token,instanceId);
        
        if(scan_id == 'Error'){
        	ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Internal Error, please contact the administrator.'));
        } else {
            this.displayLaunchScan = true;
        	GET_Scan.getscan(token,scan_id,instanceId);
        }
    }
    
    
	public PageReference refresh() {
        this.displayLaunchScan = true;
        this.displayCreateCustomer= false;
        getTokenPassword();
        
        List<String> scansRunningId = new List<String>();
       
        for(Scan__c sc : scans){
            if(sc.Status__c == 'RUNNING' ){
                scansRunningId.add(sc.longID__C);
                instanceId = sc.URL_Id__c;
            }
        }
        if(!scansRunningId.isEmpty()){
            for(String scRun : scansRunningId){
            	GET_Scan.getscan(token,scRun,instanceId);
            }
        }
        PageReference tempPage = ApexPages.currentPage();            
        tempPage.setRedirect(true);
        return tempPage;
    }
    
    public void getTokenPassword(){
        Check_CredentialUser checkInst = new Check_CredentialUser();
        Check_Token checkTok = new Check_Token();
        this.token = checkTok.verifyToken();
        this.instanceId = checkInst.verifyOrgId();
    }
    
    public void newToken(){
        String newToken = POST_Token.setToken(usernameQC,passwordQC);
        if(newToken != 'Error Token'){
            Insert_Token insNewToken = new Insert_Token();
            insNewToken.insertToken(newToken);
            this.token = 'Bearer '+newToken;
            this.displayPopupCredentialsQC = false;
            this.displayCreateCustomer = false;
            this.displayPopupPwdToken = true;
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Please, enter Password and Security Token with no space (Ex. Password = "Hello" , Security Token = "World" --> "HelloWorld") :'));
        } else {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Please review Username and Password, if the problem persist contact the admin.'));
        }
    }
    
    public static Boolean runningInASandbox() {
  		return [SELECT IsSandbox FROM Organization LIMIT 1].IsSandbox;
	}
    
   
}