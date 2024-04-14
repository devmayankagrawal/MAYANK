public class PrefixApplicantHelper {
    
    public static void prefixApplicantFirstName(List<Applicant__c>appList){
        
        for(Applicant__c objApp : appList){
            
            if(String.isNotBlank(objApp.First_Name__c)){
                
                
                if((objApp.First_Name__c.startsWith('Mr.') || objApp.First_Name__c.startsWith('Ms.'))){
                    if(objApp.First_Name__c.startsWith('Mr.')){
                        objApp.First_Name__c = objApp.First_Name__c.remove('Mr.');
                    }
                    else{
                        objApp.First_Name__c = objApp.First_Name__c.remove('Ms.');
                    }
                }
                
                if(objApp.Gender__c=='Male' && !objApp.First_Name__c.startsWith('Mr.')){
                    objApp.First_Name__c =  'Mr.'+objApp.First_Name__c;
                }
                else{
                    if(objApp.Gender__c == 'Female'  && !objApp.First_Name__c.startsWith('Ms.')){
                        objApp.First_Name__c =  'Ms.'+objApp.First_Name__c; 
                    }
                    else{
                        if(objApp.Gender__c == 'Transgender')
                            objApp.addError('Transgender is currently not allowed...!!!');
                    }
                }
            }
            
            else{
                objApp.First_Name__c.addError('Please enter first name'); 
            }
        }
        
    }
}