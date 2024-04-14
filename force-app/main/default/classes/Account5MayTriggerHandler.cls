public class Account5MayTriggerHandler {
    
    public static Boolean flag = false;
    
    public static void beforeInsert(List<Account> accList){
        
        if(!flag){
            flag = true;
            Account5MayTriggerHelper.updateAccount(accList);
        }
    }
}