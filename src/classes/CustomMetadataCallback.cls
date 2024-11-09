/**
 * Created By: Antonino Cupi
 * Date: 30/04/2018
 * Description: Standard class implements class to insert Custom Metadata Type Token_Quality_Clouds
**/
public class CustomMetadataCallback implements Metadata.DeployCallback {
    public void handleResult(Metadata.DeployResult result,
                             Metadata.DeployCallbackContext context) {
        if (result.status == Metadata.DeployStatus.Succeeded) {
            System.debug(' ===>'+ result);
        } else {
            // Deployment was not successful
            System.debug(' ===> fail '+ result);
        }
    }
}