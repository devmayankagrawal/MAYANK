public class AccountTriggerHandler6June {

    public static void beforeInsert(List<Account>accList){
        AccountTriggerHelper6June.updateAccount(accList,null);
    }
    public static void beforeUpdate(List<Account>accList,Map<Id,Account>accOLdMap){
        AccountTriggerHelper6June.updateAccount(accList,accOLdMap);
    }
}