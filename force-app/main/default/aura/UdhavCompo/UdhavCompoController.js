({
	sendController : function(component, event, helper) {
		
        component.set('v.sendAmount', component.get('v.thakreAmount'));
	},
    
    receiveDataController : function(component, event, helper){
        
        var receivedData = event.getParam("rashmiEventAmount");
        console.log('Received from Aditya ='+receivedData);
        component.set('v.receivedFromAditya',receivedData);
    }
})