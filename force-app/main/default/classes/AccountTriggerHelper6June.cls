public class AccountTriggerHelper6June {
    
    public static void updateAccount(List<Account>accList, Map<Id,Account> accOLdMap){
        
        if(!accList.isEmpty()){
            for(Account objAcc : accList){
                if(string.isNotBlank(objAcc.Type)&& objAcc.Type=='Prospect'){
                    if(trigger.isInsert && trigger.isBefore){
                        objAcc.Rating='Hot';
                    }
                    if(trigger.isUpdate && trigger.isBefore){
                        if(objAcc.Type != accOLdMap.get(objAcc.Id).Type){
                            objAcc.Rating='Hot';
                        }
                    }
                }
                else{
                    objAcc.Rating='';
                }
            }
        }
    }
}