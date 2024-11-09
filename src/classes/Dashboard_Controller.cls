/**
 * Created By: Antonino Cupi
 * Date: 06/04/2018
 * Description: Controller of the Visualforce "Dashboard_Page"
**/
public class Dashboard_Controller {
    public boolean displayError;
    // Return a list of data points for a chart
    public List<Data> getData() {
        return getChartData();
    }
    
    public List<Data> getChartData() {
        Decimal iss;
        Decimal deb;
        Decimal lin;
        String scDate;
        List<Scan__c> sc = new List<Scan__c>();
        sc = [SELECT Scan_Date__c,Issues__c,Code_Lines__c,Technical_Debt__c,status__c from Scan__c where status__c = 'SUCCESS' OR status__c = 'WARNING' Order by Scan_Date__c asc ];
        
        if(sc.isEmpty() || sc==null){
            return null;
        } else {
            List<Data> data = new List<Data>();
            for(Scan__c s : sc){
                iss = s.Issues__c;
                deb = s.Technical_Debt__c;
                lin = s.Code_Lines__c;
                scDate = string.Valueof(s.Scan_Date__c);
                data.add(new Data(iss,deb,lin,scDate));
            }
            return data;
        }
    }
    
    public boolean getDisplayError(){
        List<Data> data = new List<Data>();
        data=getChartData();
        if(data==null){
            return true;
        }else{
            return false;
        }
    }
    
    
    // Wrapper class
    public class Data {
     
        public Decimal issues { get; set; }
        public Decimal tecDeb { get; set; }
        public Decimal codLin { get; set; }
        public String scanDate { get; set; }
        public Data(Decimal issues, Decimal tecDeb, Decimal codLin, String scanDate) {
      
            this.issues = issues;
            this.tecDeb = tecDeb;
            this.codLin = codLin;
            this.scanDate = scanDate;
            
        }
    }

}