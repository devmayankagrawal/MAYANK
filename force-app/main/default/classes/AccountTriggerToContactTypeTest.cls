@isTest
public class AccountTriggerToContactTypeTest {
    
    public static testMethod void testAccountToContact(){
        Account objAcc = new Account(Name='Cinemax');
        insert objAcc;
        
        List<Contact> conList = new List<Contact>();
        for(integer i=1;i<=200;i++){
            Contact objCon = new Contact(FirstName='Bunty'+i,LastName='Modi'+i,AccountId = objAcc.Id);
            conList.add(objCon);
        }
        if(!conList.isEmpty()){
            Database.insert(conList,False);
        }
        Account objAccResult = [select Id,Type from Account where Id =: objAcc.Id];
        objAccResult.Type='Technology Partner';
        update objAccResult;
        
        List<Contact> conListResult = [select Id,LeadSource,Level__c from Contact where AccountId=:objAcc.Id and LeadSource='Web' and Level__c='Primary'];
        system.assertEquals(200,conListResult.size());
    }
    public static testMethod void testAccountToContactElse(){
        Account objAcc = new Account(Name='Cinemax');
        insert objAcc;
        
        List<Contact> conList = new List<Contact>();
        for(integer i=1;i<=200;i++){
            Contact objCon = new Contact(FirstName='Bunty'+i,LastName='Modi'+i,AccountId = objAcc.Id);
            conList.add(objCon);
        }
        if(!conList.isEmpty()){
            Database.insert(conList,False);
        }
        Account objAccResult = [select Id,Type from Account where Id =: objAcc.Id];
        objAccResult.Type='Prospect';
        update objAccResult;
        
        List<Contact> conListResult = [select Id,LeadSource,Level__c from Contact where AccountId=:objAcc.Id and LeadSource='' and Level__c=''];
        system.assertEquals(200,conListResult.size());
    }
}