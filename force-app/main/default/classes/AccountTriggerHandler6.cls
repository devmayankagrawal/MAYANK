public class AccountTriggerHandler6 {
    
    public static boolean flag=false;
    
    public static void beforeInsert(List<Account>accList){
        
        if(!flag){
            flag=true;
            AccountTriggerHelper6.updateAccount(accList);
        }
    }
}