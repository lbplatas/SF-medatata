/**
 * Created By: Antonino Cupi
 * Date: 06/04/2018
 * Description: Retrieve the info from last scan and insert in SF a new scan with the informations
**/
public class Insert_Scan {
	 
 
    public static void retrieveInfo(String status, String json, String scan_id, String instanceId){
        
        Scan_Json_Parse js = Scan_Json_Parse.parse(json);
        Integer issues = js.data.attributes.number_of_issues;
        String tecDebt = js.data.attributes.technical_debt;
        String scanDate = js.data.attributes.scan_date;
        String statusScan = js.data.attributes.status;
        String scanId = js.data.id;
        String url = js.data.attributes.url;
        String target = js.data.attributes.target;
        Integer customer_id = js.data.attributes.customer_id;
        Integer user_id = js.data.attributes.user_id;
        Integer internal_code = js.data.attributes.internal_code;
        Integer exit_code = js.data.attributes.exit_code;
        String process_time = js.data.attributes.process_time;
        String quality_of_cloud = js.data.attributes.quality_of_cloud;
        Integer best_practices_number = js.data.attributes.best_practices_number;
        Integer scanned_configuration_elements = js.data.attributes.scanned_configuration_elements;
        Integer code_lines = js.data.attributes.code_lines;
        String changes_issues_ratio = js.data.attributes.changes_issues_ratio;
        String code_changes_issues_ratio = js.data.attributes.code_changes_issues_ratio;
        String administrators = js.data.attributes.administrators;
        String users = js.data.attributes.users;
        String instance_build_date = js.data.attributes.instance_build_date;
        String last_upgrade_date = js.data.attributes.last_upgrade_date;
        String last_update_set_date = js.data.attributes.last_update_set_date;
        String issues_variation = js.data.attributes.issues_variation;
        String technical_debt_variation = js.data.attributes.technical_debt_variation;
        String quality_of_cloud_variation = js.data.attributes.quality_of_cloud_variation;
        Integer code_lines_added = js.data.attributes.code_lines_added;
        String engine_version = js.data.attributes.engine_version;
        
        
        
		Scan__c scanRunning = new Scan__c();        
        try{
            scanRunning = [Select name, Issues__c,Scan_Date__c,Code_Lines__c,Technical_Debt__c,longID__C,Status__c,URL__c,Target__c,Customer_Id__c,User_id__c,Process_Time__c,Quality_of_Cloud__c,BP_Number__c,Scanned_Conf_Elems__c,Changes_Issues_Ratio__c,Codechanges_Issues_Ratio__c,Administrators__c,Users__c,Issues_Var__c,Techdebt_Var__c,QOC_Var__c,Code_Lines_Added__c,Engine_Version__c from Scan__c where longID__C =: scan_id LIMIT 1];
            system.debug('*** scanRunning: '+scanRunning);
        }catch(exception e){
            scanRunning = null;
        }
        
        if(scanRunning == null){
            
            Scan__c scan = new Scan__c();
            scan.Issues__c = decimal.valueOf(issues);
            if(scanDate != null){
                scan.Scan_Date__c = DateTime.valueOf((scanDate).replaceAll('/','-'));
            }
            if(tecDebt != null){
                scan.Technical_Debt__c = decimal.valueOf(tecDebt);
            }
            scan.Status__c = statusScan;
            scan.longID__C = scanId;
            scan.URL_Id__c = instanceId;
            scan.URL__c = url;
            scan.Target__c = target;
            scan.Customer_Id__c = customer_id;
            scan.User_id__c = string.valueOf(user_id);
            if(process_time != null){
            	scan.Process_Time__c = decimal.valueOf(process_time);
            }
            if(quality_of_cloud != null){
            	scan.Quality_of_Cloud__c = decimal.valueOf(quality_of_cloud);
            }
            scan.BP_Number__c = best_practices_number;
            scan.Scanned_Conf_Elems__c = scanned_configuration_elements;
            if(changes_issues_ratio != null){
            	scan.Changes_Issues_Ratio__c = decimal.valueOf(changes_issues_ratio);
            }
            if(code_changes_issues_ratio != null){
            	scan.Codechanges_Issues_Ratio__c = decimal.valueOf(code_changes_issues_ratio);
            }    
            scan.Administrators__c = administrators;
            scan.Users__c  = users;
            if(issues_variation != null){
            	scan.Issues_Var__c = decimal.valueOf(issues_variation);
            }
            scan.Techdebt_Var__c = technical_debt_variation;
            if(quality_of_cloud_variation != null){
            	scan.QOC_Var__c = decimal.valueOf(quality_of_cloud_variation);
            }    
            scan.Code_Lines_Added__c = code_lines_added;
            scan.Code_Lines__c = code_lines;
            scan.Engine_Version__c = engine_version;
            insert scan;
            
        } else {
            
            scanRunning.Issues__c = decimal.valueOf(issues);
            if(scanDate != null){
                scanRunning.Scan_Date__c = DateTime.valueOf((scanDate).replaceAll('/','-'));
            }
            if(tecDebt != null){
                scanRunning.Technical_Debt__c = decimal.valueOf(tecDebt);
            }
            scanRunning.Status__c = statusScan;
            scanRunning.longID__C = scanId;
            scanRunning.URL_Id__c = instanceId;
            scanRunning.URL__c = url;
            scanRunning.Target__c = target;
            scanRunning.Customer_Id__c = customer_id;
            scanRunning.User_id__c = string.valueOf(user_id);
            if(process_time != null){
            	scanRunning.Process_Time__c = decimal.valueOf(process_time);
            }
            if(quality_of_cloud != null){
            	scanRunning.Quality_of_Cloud__c = decimal.valueOf(quality_of_cloud);
            }
            scanRunning.BP_Number__c = best_practices_number;
            scanRunning.Scanned_Conf_Elems__c = scanned_configuration_elements;
            if(changes_issues_ratio != null){
            	scanRunning.Changes_Issues_Ratio__c = decimal.valueOf(changes_issues_ratio);
            }
            if(code_changes_issues_ratio != null){
            	scanRunning.Codechanges_Issues_Ratio__c = decimal.valueOf(code_changes_issues_ratio);
            }    
            scanRunning.Administrators__c = administrators;
            scanRunning.Users__c  = users;
            if(issues_variation != null){
            	scanRunning.Issues_Var__c = decimal.valueOf(issues_variation);
            }
            scanRunning.Techdebt_Var__c = technical_debt_variation;
            if(quality_of_cloud_variation != null){
            	scanRunning.QOC_Var__c = decimal.valueOf(quality_of_cloud_variation);
            } 
            scanRunning.Code_Lines_Added__c = code_lines_added;
            scanRunning.Engine_Version__c = engine_version;
            scanRunning.Code_Lines__c = code_lines;
            update scanRunning;
            
        }
    }

}