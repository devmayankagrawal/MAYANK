({
	searchAccountController : function(component, event, helper) {
        
        component.set('v.showSpinnerFlag', true);
		helper.searchAccountHelper(component, event, helper);
	}
})