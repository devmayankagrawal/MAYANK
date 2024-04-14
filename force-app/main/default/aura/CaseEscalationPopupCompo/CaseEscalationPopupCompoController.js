({
	escalateCaseController : function(component, event, helper) {
		
        var popupFire = component.getEvent("CaseEscalationEventRegistration");
        popupFire.setParams({"showPopupModalFlagEvent" : false, "CaseObjectEvent" : component.get('v.receivedCaseObject')});;
        popupFire.fire();
	}
   
})