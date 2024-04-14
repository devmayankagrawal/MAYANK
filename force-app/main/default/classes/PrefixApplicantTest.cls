@isTest
public class PrefixApplicantTest {
	
    public static testMethod void prefixMaleTest(){
        Date dob = date.parse('05/11/1997');
        
        Applicant__c objApp = new Applicant__c(First_Name__c='Raju',Last_Name__c='Kumar',Gender__c='Male',DOB__c=dob);
        insert objApp;
        
        string actualFirstName = [select First_Name__c,Last_Name__c from Applicant__c where Id =: objApp.Id].First_Name__c;
        system.assertEquals('Mr.Raju',actualFirstName);
        
        //Update
        Applicant__c appData = [select First_Name__c,Gender__c from Applicant__c where Id =: objApp.Id LIMIT 1];
        appData.First_Name__c='Ms.Chachu';
        update appData;
        
        string actualFirstNameUpdate = [select First_Name__c,Gender__c from Applicant__c where Id =: appData.Id].First_Name__c;
        system.assertEquals('Mr.Chachu', actualFirstNameUpdate);
    }
    public static testMethod void prefixFemaleTest(){
        Date dob = date.parse('05/11/1997');
        
        Applicant__c objApp = new Applicant__c(First_Name__c='Pinki',Last_Name__c='Kumar',Gender__c='Female',DOB__c=dob);
        insert objApp;
        
        string actualFirstName = [select First_Name__c,Last_Name__c from Applicant__c where Id =: objApp.Id].First_Name__c;
        system.assertEquals('Ms.Pinki',actualFirstName);
        
        //Update
        Applicant__c appData = [select First_Name__c,Gender__c from Applicant__c where Id =: objApp.Id LIMIT 1];
        appData.First_Name__c='Mr.Sima';
        update appData;
        
        string actualFirstNameUpdate = [select First_Name__c,Gender__c from Applicant__c where Id =: appData.Id].First_Name__c;
        system.assertEquals('Ms.Sima', actualFirstNameUpdate);
    }
    public static testMethod void prefixTransgenderTest(){
        try{
        Date dob = date.parse('05/11/1997');
         Applicant__c objApp = new Applicant__c(First_Name__c='Sangita',Last_Name__c='Kumar',Gender__c='Transgender',DOB__c=dob);
        insert objApp;
        }
        catch(Exception ex){
            boolean result = ex.getMessage().contains('Transgender is currently not allowed...!!!') ? true : false;
            system.assertEquals(true,result);
        }
        
    }
}