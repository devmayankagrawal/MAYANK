({
	showAccountDataController : function(component, event, helper) {
		console.log('I am from JS Controller');
        helper.showAccountDataHelper(component, event, helper);
        component.set('v.showTableFlag',true);
        
                component.set('v.oppTableColList', [
            {label: 'Opportunity', fieldName: 'Name', type: 'text'},
            {label: 'Lead Source', fieldName: 'LeadSource', type: 'text'},
            {label: 'Stage Name', fieldName: 'StageName', type: 'text'},
            {label: 'Amount', fieldName: 'Amount', type: 'text'}
        ]);

	},
    
    selectedOpportunityRows :  function(component, event, helper) {
        var selectedOpportunityRows =  event.getParam('selectedRows');// Array
        console.log("Count = "+selectedOpportunityRows.length);        
        component.set('v.selectedRecordCount', selectedOpportunityRows.length);    
        
        var selectedOppRows=[];
         for(var i=0; i<selectedOpportunityRows.length; i++){
            selectedOppRows.push(selectedOpportunityRows[i]);
        }
        
        component.set('v.selectedOpportunityRecordList', selectedOppRows); 
        
    },
    deleteSelectedOpportunityController : function(component, event, helper) {
        helper.deleteSelectedOpportunityHelper(component, event, helper);
        console.log('i am from JS controller');
    }

})