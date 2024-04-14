({
	receiveDataController : function(component, event, helper) {
		
        console.log('Thakre Js method called');
        
        var receivedData = event.getParam('sitaramanEventAccName');
        console.log('Received data = '+receivedData);
        
        component.set('v.receivedfromModi',receivedData);
	}
})