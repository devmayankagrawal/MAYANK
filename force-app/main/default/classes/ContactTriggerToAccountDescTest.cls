@isTest
public class ContactTriggerToAccountDescTest {

    public static testMethod void testContactToAccountInsert(){
        Account objAcc = new Account(Name='Cinemax');
        insert objAcc;
        
        List<Contact> conList = new List<Contact>();
        for(integer i=1;i<=200;i++){
        Contact objCon = new Contact(FirstName='Bunty'+i,LastName='Modi'+i,AccountId=objAcc.Id);
            conList.add(objCon);
        }
        if(!conList.isEmpty()){
            Database.insert(conList,false);
        }
        string descriptionActual = [select Id,Description from Account where Id =: objAcc.Id].Description;
        string expectedStartWith = 'Bunty1 Modi1';
        string expectedEndsWith = 'Bunty200 Modi200';
        
        boolean flag = false;
        if(descriptionActual.startsWith(expectedStartWith) && descriptionActual.endsWith(expectedEndsWith)){
            flag = true;
        }
        system.assert(flag);
    }
    
}