({
	showDetailsHelper : function(component, event, helper) {
		console.log('I am from JS helper');
        
        var action = component.get('c.getCaseDetails');
        action.setParams({"objCase" : component.get('v.caseObject')});
        action.setCallback(this,function(response){
            if(response.getState()==='SUCCESS'){
                console.log('Success'+JSON.stringify(response.getReturnValue()));
                component.set('v.caseList',response.getReturnValue());
            }
            else{
                console.log('Locha..Something went wrong');
            }
        });
        
        
        $A.enqueueAction(action);
        
	}
})