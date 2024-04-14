({
	sendToThakreController : function(component, event, helper) {
		
        var sitaramEventFire = $A.get('e.c:SitaramanEvent');
        sitaramEventFire.setParams({"sitaramanEventAccName" : component.get('v.accName')});
        sitaramEventFire.fire();
        
        console.log('event has been fired');
	}
})