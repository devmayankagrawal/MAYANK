public class PrefixApplicantHandler {

    public static void beforeInsert(List<Applicant__c>appList){
        PrefixApplicantHelper.prefixApplicantFirstName(appList);
    }
     public static void beforeUpdate(List<Applicant__c>appList){
        PrefixApplicantHelper.prefixApplicantFirstName(appList);
    }
}