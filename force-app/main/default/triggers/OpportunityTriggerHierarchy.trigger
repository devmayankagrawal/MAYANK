trigger OpportunityTriggerHierarchy on Opportunity (before insert, before update) {
    
    for(Opportunity objOpp : trigger.new){
        if(objOpp.Customer_Type__c=='Normal'){
            Diwali_Discounts__c diwaliDisc = Diwali_Discounts__c.getOrgDefaults();
            
            objOpp.Discount_Percentage__c = diwaliDisc.Discount_Percentage__c;
            objOpp.Discount_Amount__c = (objOpp.Amount*diwaliDisc.Discount_Percentage__c)/100;
            objOpp.Actual_Amount_after_Discount__c = objOpp.Amount - ((objOpp.Amount*diwaliDisc.Discount_Percentage__c)/100);
        }
        else{
            if(objOpp.Customer_Type__c=='Prime'){
                Diwali_Discounts__c diwaliDisc = Diwali_Discounts__c.getInstance(Userinfo.getProfileId());
                
                objOpp.Discount_Percentage__c = diwaliDisc.Discount_Percentage__c;
                objOpp.Discount_Amount__c = (objOpp.Amount*diwaliDisc.Discount_Percentage__c)/100;
                objOpp.Actual_Amount_after_Discount__c = objOpp.Amount - ((objOpp.Amount*diwaliDisc.Discount_Percentage__c)/100);
            }
            else{
                if(objOpp.Customer_Type__c=='Special'){
                    Diwali_Discounts__c diwaliDisc = Diwali_Discounts__c.getInstance(Userinfo.getUserId());
                    
                    objOpp.Discount_Percentage__c = diwaliDisc.Discount_Percentage__c;
                    objOpp.Discount_Amount__c = (objOpp.Amount*diwaliDisc.Discount_Percentage__c)/100;
                    objOpp.Actual_Amount_after_Discount__c = objOpp.Amount - ((objOpp.Amount*diwaliDisc.Discount_Percentage__c)/100);
                }
            }
        }
    }
    
}