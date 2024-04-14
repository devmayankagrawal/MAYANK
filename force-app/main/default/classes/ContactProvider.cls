public without sharing class ContactProvider {
    
    @AuraEnabled
    public static string createContactForm(String strSignElement,Contact objCon,String base64, String filename){
        try {           

            if(objCon != null){
                insert objCon;

        // Create Salesforce File
        //Insert ContentVersion
        ContentVersion cVersion = new ContentVersion();
        cVersion.ContentLocation = 'S'; //S-Document is in Salesforce. E-Document is outside of Salesforce. L-Document is on a Social Netork.
        cVersion.PathOnClient = 'Signature-'+System.now() +'.png';//File name with extention
        cVersion.Origin = 'H';//C-Content Origin. H-Chatter Origin.
        //cVersion.OwnerId = attach.OwnerId;//Owner of the file
        cVersion.Title = 'Signature-'+System.now() +'.png';//Name of the file
        cVersion.VersionData = EncodingUtil.base64Decode(strSignElement);//File content
        Insert cVersion;
        
        //After saved the Content Verison, get the ContentDocumentId
        Id conDocument = [SELECT ContentDocumentId FROM ContentVersion WHERE Id =:cVersion.Id].ContentDocumentId;
        
        //Insert ContentDocumentLink
        ContentDocumentLink cDocLink = new ContentDocumentLink();
        cDocLink.ContentDocumentId = conDocument;//Add ContentDocumentId
        cDocLink.LinkedEntityId = objCon.Id;//Add attachment parentId
        cDocLink.ShareType = 'I';//V - Viewer permission. C - Collaborator permission. I - Inferred permission.
        cDocLink.Visibility = 'AllUsers';//AllUsers, InternalUsers, SharedUsers
        Insert cDocLink;

        //Insert File/Upload File
        ContentVersion cv = new ContentVersion();
            cv.VersionData = EncodingUtil.base64Decode(base64);
            cv.Title = filename;
            cv.PathOnClient = filename;
            insert cv;

            ContentDocumentLink cdl = new ContentDocumentLink();
            cdl.ContentDocumentId = [SELECT ContentDocumentId FROM ContentVersion WHERE Id =: cv.Id].ContentDocumentId;
            cdl.LinkedEntityId = objCon.Id;
            // ShareType is either 'V', 'C', or 'I'
            // V = Viewer, C = Collaborator, I = Inferred
            cdl.ShareType = 'I';
            insert cdl;
            
                return 'Contact Created';
            }
            else {
                return 'Lochaaa..';
            }
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

       /* @AuraEnabled
        public static String uploadFile(String base64, String filename, String recordId) {
                ContentVersion cv = createContentVersion(base64, filename);
                ContentDocumentLink cdl = createContentLink(cv.Id, recordId);
                if (cv == null || cdl == null) { return null; }
                return cdl.Id;
        }

        private static ContentVersion createContentVersion(String base64, String filename) {
            ContentVersion cv = new ContentVersion();
            cv.VersionData = EncodingUtil.base64Decode(base64);
            cv.Title = filename;
            cv.PathOnClient = filename;
            try {
              insert cv;
              return cv;
            } catch(DMLException e) {
              System.debug(e);
              return null;
            }
          }

          private static ContentDocumentLink createContentLink(String contentVersionId, String recordId) {
            if (contentVersionId == null || recordId == null) { return null; }
            ContentDocumentLink cdl = new ContentDocumentLink();
            cdl.ContentDocumentId = [SELECT ContentDocumentId FROM ContentVersion WHERE Id =: contentVersionId].ContentDocumentId;
            cdl.LinkedEntityId = recordId;
            // ShareType is either 'V', 'C', or 'I'
            // V = Viewer, C = Collaborator, I = Inferred
            cdl.ShareType = 'V';
                try {
                    insert cdl;
                    return cdl;
                } catch(DMLException e) {
                    System.debug(e);
                    return null;
                }
            }
*/

   /* @AuraEnabled
    public static string createContactForm(Contact objCon, String strSignElement){
        try {
            if (objCon != null && strSignElement != null) {
                // Create a new Contact record
                insert objCon;
    
                // Convert the base64-encoded signature image data to Attachment
                Attachment signatureAttachment = new Attachment();
                signatureAttachment.Name = 'Signature.png'; // Adjust the filename as needed
                signatureAttachment.ParentId = objCon.Id; // Link the Attachment to the Contact
                signatureAttachment.ContentType = 'image/png'; // Set the content type accordingly
                signatureAttachment.Body = EncodingUtil.base64Decode(strSignElement);
    
                // Insert the Attachment
                insert signatureAttachment;
    
                return 'Contact Created with Signature';
            } else {
                return 'Missing Contact Information or Signature Data';
            }
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }*/
    @AuraEnabled
    public static void saveSign(String strSignElement,Id recId){

        // Create Salesforce File
        //Insert ContentVersion
        ContentVersion cVersion = new ContentVersion();
        cVersion.ContentLocation = 'S'; //S-Document is in Salesforce. E-Document is outside of Salesforce. L-Document is on a Social Netork.
        cVersion.PathOnClient = 'Signature-'+System.now() +'.png';//File name with extention
        cVersion.Origin = 'H';//C-Content Origin. H-Chatter Origin.
        //cVersion.OwnerId = attach.OwnerId;//Owner of the file
        cVersion.Title = 'Signature-'+System.now() +'.png';//Name of the file
        cVersion.VersionData = EncodingUtil.base64Decode(strSignElement);//File content
        Insert cVersion;
        
        //After saved the Content Verison, get the ContentDocumentId
        Id conDocument = [SELECT ContentDocumentId FROM ContentVersion WHERE Id =:cVersion.Id].ContentDocumentId;
        
        //Insert ContentDocumentLink
        ContentDocumentLink cDocLink = new ContentDocumentLink();
        cDocLink.ContentDocumentId = conDocument;//Add ContentDocumentId
        cDocLink.LinkedEntityId = recId;//Add attachment parentId
        cDocLink.ShareType = 'I';//V - Viewer permission. C - Collaborator permission. I - Inferred permission.
        cDocLink.Visibility = 'AllUsers';//AllUsers, InternalUsers, SharedUsers
        Insert cDocLink;

        // Create attachement
        /*
        Attachment objAttachment = new Attachment();
        objAttachment.Name = 'Demo-Signature.png';
        objAttachment.ParentId = recId;
        objAttachment.ContentType = 'image/png';
        objAttachment.Body = EncodingUtil.base64Decode(strSignElement);        
        insert objAttachment;
        return objAttachment;      
        */ 
    }
}