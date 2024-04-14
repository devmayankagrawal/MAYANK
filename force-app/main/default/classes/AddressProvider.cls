public with sharing class AddressProvider {
    public AddressProvider() {

    }
    @AuraEnabled
    public static void createAddressRecord(Address__c objAddr){
        try {
                insert objAddr;
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}