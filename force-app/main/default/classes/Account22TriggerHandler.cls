public class Account22TriggerHandler {
    
    public static Boolean flag = false;
    
    public static void beforeInsert(List<Account> accList){
        
        if(!flag){
            flag = true;
            Account22TriggerHelper.updateAccount(accList);
        }
    }
    
    
}