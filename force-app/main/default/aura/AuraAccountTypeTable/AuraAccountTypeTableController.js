({
	accTypeController : function(component, event, helper) {
		console.log('You have selected'+component.get('v.accountObject.Type'));
        
        component.set('v.accTableColList', [
            {label: 'Account Name', fieldName: 'Name', type: 'text'},
            {label: 'Type', fieldName: 'Type', type: 'text'},
            {label: 'SLA', fieldName: 'SLA__c', type: 'text'},
            {label: 'Rating', fieldName: 'Rating', type: 'text'}
        ]);
        
		helper.accTypeHelper(component, event, helper);
       
        component.set('v.showSpinnerFlag',true);
	}
})