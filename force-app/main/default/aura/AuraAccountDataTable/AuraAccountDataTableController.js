({
    showOpportunitiesController : function(component, event, helper) {
        
        component.set('v.oppTableColList', [
            {label: 'Opp Nmae', fieldName: 'Name', type: 'text'},
            {label: 'Account Name', fieldName: 'AccountName', type: 'text'},
            {label: 'Stage Name', fieldName: 'StageName', type: 'text'},
            {label: 'Amount', fieldName: 'Amount', type: 'text'}
        ]);

        
        component.set('v.showSpinnerFlag', true);
        helper.showOpportunitiesHelper(component, event, helper);
    },
    
        selectedAddressRows :  function(component, event, helper) {
        var selectedAddressRows =  event.getParam('selectedRows');// Array
        console.log("Count = "+selectedAddressRows.length);        
        component.set('v.selectedRecordCount', selectedAddressRows.length);    
        
        var selectedAdrRows=[];
         for(var i=0; i<selectedAddressRows.length; i++){
            selectedAdrRows.push(selectedAddressRows[i]);
        }
        
        component.set('v.selectedOpportunityRecordList', selectedAdrRows); 
        
        

      
    },
    
    deleteSelectedOpportunityController : function(component, event, helper) {
        helper.deleteSelectedOpportunityHelper(component, event, helper);
    }
})