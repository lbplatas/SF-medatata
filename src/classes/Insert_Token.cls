/**
 * Created By: Antonino Cupi
 * Date: 30/04/2018
 * Description: Insert Custom Metadata Type Token_Quality_Clouds with the Access_Token
**/
public class Insert_Token {
    
    public void insertToken(String token){
        Metadata.CustomMetadata customMetadata =  new Metadata.CustomMetadata();
        customMetadata.fullName = 'Token_Quality_Clouds.Token_Org';
        customMetadata.label = 'Token Org';
    
        Metadata.CustomMetadataValue customField = new Metadata.CustomMetadataValue();
        customField.field = 'Token__c';
        customField.value = 'Bearer '+token;
    
        customMetadata.values.add(customField);
    
        Metadata.DeployContainer mdContainer = new Metadata.DeployContainer();
        mdContainer.addMetadata(customMetadata);
        
        CustomMetadataCallback callback = new CustomMetadataCallback();
    
  //    Id jobId = Metadata.Operations.enqueueDeployment(mdContainer, callback);
        Id jobId = Test.isRunningTest() ? '0010N00004AimU7' : Metadata.Operations.enqueueDeployment(mdContainer, callback);
    }

}