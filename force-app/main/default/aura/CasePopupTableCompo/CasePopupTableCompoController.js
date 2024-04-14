({
	doInit : function(component, event, helper) {
		
        component.set('v.caseTableColList', [
            {label: 'Case Number', fieldName: 'CaseNumber', type: 'text'},
            {label: 'Status', fieldName: 'Status', type: 'text'},
            {label: 'Origin', fieldName: 'Origin', type: 'text'},
            {label: 'Priority', fieldName: 'Priority', type: 'text'}
        ]);

	},
    
    closePopupController : function(component, event, helper) {
        var caseEventFire = component.getEvent("caseEventRegister");
        caseEventFire.setParams({"caseEventShowPopupFlag" : false});
        caseEventFire.fire();
        console.log('Event Fired');
    }
})