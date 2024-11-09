/**
 * Created By: Antonino Cupi
 * Date: 06/04/2018
 * Description: Controller of the Apex Component "Governance_Component"
**/
public class Governance_Component_Controller {
    
    public Scan__c scan { get; set; }
    public boolean trendingUp { get; set; }
    public boolean trendingDown { get; set; }
    public boolean trendingIgual { get; set; }
    
    public Governance_Component_Controller() {
        
      	List<Scan__c> scans = new List<Scan__c>();
        scans = [Select Scan_Date__c,Status__c, Issues__c from Scan__c where Status__c = 'SUCCESS' order by Scan_Date__c DESC LIMIT 2];
      
        if(!scans.isEmpty() && scans!=null){
            scan = scans[0];
            
            if(scans.size()>1){
                // Start Trending Logic to show the correct image
                Scan__c scanOld = scans[1];
                Decimal issuesOld = scanOld.Issues__c;
                Decimal issuesNew = scan.Issues__c;
                
                if(issuesOld > issuesNew){
                    this.trendingUp = false;
                    this.trendingDown = true;
                    this.trendingIgual = false;
                } else if(issuesOld < issuesNew){
                    this.trendingUp = true;
                    this.trendingDown = false;
                    this.trendingIgual = false;
                } else {
                    this.trendingUp = false;
                    this.trendingDown = false;
                    this.trendingIgual = true;
                }
            }
    	}
    }

}