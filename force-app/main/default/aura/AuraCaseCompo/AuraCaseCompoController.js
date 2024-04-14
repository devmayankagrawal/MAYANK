({
	showDetailsController : function(component, event, helper) {
		helper.showDetailsHelper(component, event, helper);
        component.set('v.showPopupFlag',true);
	},
    
    receiveDataController : function(component, event, helper) {
        var receivedData = event.getParam("caseEventShowPopupFlag");
        	console.log('Zatkaa Laga..');
        	console.log("Received Data="+receivedData);
        component.set('v.showPopupFlag',receivedData);
    }
})