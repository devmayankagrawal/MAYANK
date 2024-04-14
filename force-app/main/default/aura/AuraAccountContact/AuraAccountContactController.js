({
	showContactController : function(component, event, helper) {
		
        var AccConEventFire = $A.get('e.c:AccountContactEvent');
       			 AccConEventFire.setParams({"AccConEventContactList" : component.get('v.accountObject')});
        		 AccConEventFire.fire();
			console.log('Event is fired');
        
	}
})