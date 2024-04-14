({
	sendUdhavController : function(component, event, helper) {
		
        var rashmiEventFire = component.getEvent("RashmiEventRegister");
        rashmiEventFire.setParams({"rashmiEventAmount" : component.get('v.adityaAmount')});
        rashmiEventFire.fire();
        console.log('Rashmi event Fired');
	}
})