({
	fireEventController : function(component, event, helper) {
		var fireEvent = component.getEvent('BubbbleEventRegister');
        fireEvent.fire();
	},
    
    handleController : function(component, event, helper){
        alert("I am from Component C");
        
    }
})