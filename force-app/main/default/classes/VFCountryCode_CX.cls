public with sharing class VFCountryCode_CX {

    public String countryCode {get; set;}
        public String selectedCountry {get; set;}
    
    public VFCountryCode_CX(ApexPages.StandardController controller) {

    }
    
            public List<SelectOption> getCountriesOptions() {
        List<SelectOption> countryOptions = new List<SelectOption>();
        
        Map<string,Country_Code__c> countryCodeMap = Country_Code__c.getAll();
        
        countryOptions.add(new SelectOption('','-None-'));
       
           for(string countryName : countryCodeMap.keySet()){
               string cLabel = countryName;
               string value = countryCodeMap.get(countryName).Code_Number__c;
               countryOptions.add(new SelectOption(value,cLabel));
       
           }
 
        return countryOptions;
    }

}