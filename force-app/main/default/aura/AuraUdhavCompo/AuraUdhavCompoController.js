({
	receiveFromChildController : function(component, event, helper) {
		var childComponent = component.find('adityaChildId');
        var receivedData = childComponent.ChildAuraMethod();
        console.log('Received data='+receivedData);
        component.set('v.receivedData',receivedData);
	}
})