({
    searchAddressesController : function(component, event, helper) {
        
        component.set('v.appTablecolumns', [
            {label: 'Address Id', fieldName: 'Name', type: 'text'},
            {label: 'Country', fieldName: 'Country__c', type: 'text'},
            {label: 'State', fieldName: 'State__c', type: 'text'},
            {label: 'City', fieldName: 'City__c', type: 'text'}
        ]);
        
        
        component.set('v.showSpinnerFlag',true);
        helper.searchAddressesHelper(component, event, helper);
        
    },
    
    selectedAddressRows : function(component, event, helper) {
        var selectedAddressRows =  event.getParam('selectedRows');// Array
        console.log("Count = "+selectedAddressRows.length);        
        component.set('v.selectedRecordCount', selectedAddressRows.length);
        
        var selectedAdrRows=[];
        for(var i=0; i<selectedAddressRows.length; i++){
            selectedAdrRows.push(selectedAddressRows[i]);
        }
        
        component.set('v.selectedAddressRecordList', selectedAdrRows); 
            
    },
    
    deleteSelectedAddressesController : function(component, event, helper) {
        helper.deleteSelectedAddressesHelper(component, event, helper);
        component.set('v.showSpinnerFlag',true);
    }
})