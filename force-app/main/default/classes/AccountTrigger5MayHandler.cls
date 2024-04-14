public class AccountTrigger5MayHandler {
    
    public static void beforeInsert(List<Account> accList){
        AccountTrigger5MayHelper.updateAccount(accList,null);
    }
    
    public static void beforeUpdate(List<Account> accList,Map<Id,Account> accOldMap){
         AccountTrigger5MayHelper.updateAccount(accList,accOldMap);

    }

}