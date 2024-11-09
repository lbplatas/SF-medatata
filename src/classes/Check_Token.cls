/**
 * Created By: Antonino Cupi
 * Date: 06/04/2018
 * Description: Verify if the token is set in the instance and return the value of the token
**/
public class Check_Token {
    
    public String verifyToken(){
        try{
		
        	Token_Quality_Clouds__mdt token = [Select Token__c , QualifiedApiName  from Token_Quality_Clouds__mdt where QualifiedApiName ='Token_Org' LIMIT 1];
            String tokenField = token.Token__c;
            if(tokenField == null){
                return null;
            } else {
            	return tokenField;         
            }
        	
        } catch (exception e){
            return null;
        }     
    }

}