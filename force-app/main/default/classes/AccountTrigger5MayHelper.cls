public class AccountTrigger5MayHelper {

    
    public static void updateAccount(List<Account> accList,Map<Id,Account> accOldMap){
        if(!acclist.isEmpty()){
            for(Account objAcc : accList){
                if(string.isNotBlank(ObjAcc.Type) && objAcc.Type=='Prospect'){
                    if(trigger.isInsert && trigger.isBefore){
                        objAcc.Rating='Hot';
                    }
                    if(trigger.isUpdate && trigger.isBefore){
                        if(objAcc.Type != accOldMap.get(objAcc.Id).Type){
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