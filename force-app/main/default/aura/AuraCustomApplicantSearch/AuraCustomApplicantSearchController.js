({
	searchApplicantController : function(component, event, helper) {
		component.set('v.showSpinnerFlag',true);
        
        helper.searchApplicantHelper(component, event, helper);
	}
})