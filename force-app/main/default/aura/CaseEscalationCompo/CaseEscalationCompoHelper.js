({
    showCaseDetailsHelper : function(component, event, helper) {
        console.log('I am from JS helper');
        
        var action = component.get('c.getCaseRecords');
        action.setParams({"objCase" : component.get('v.caseObject')});
        $A.enqueueAction(action);
        
        action.setCallback(this,function(response){
            if(response.getState()==='SUCCESS'){
                console.log('success= '+JSON.stringify(response.getReturnValue()));
                component.set('v.caseObject',response.getReturnValue());
                
                if(response.getReturnValue().Status=='Escalated'){
                    component.set('v.escalatebuttonvariantname','success');
                    component.set('v.escalatebuttonlabel','Re-open');
                }
                else{
                    component.set('v.escalatebuttonvariantname','destructive');
                    component.set('v.escalatebuttonlabel','Escalate');
                }
            }
            else{
                console.log('Lochaaa');
            }
        });
    },
    
    reOpenCaseHelper : function(component, event, helper) {
        
        var action = component.get('c.updateCaseRecordsNew');
        action.setParams({"objCase" : component.get('v.caseObject')});
        $A.enqueueAction(action);
        
        action.setCallback(this,function(response){
            if(response.getState()==='SUCCESS'){
                console.log('success= '+JSON.stringify(response.getReturnValue()));
                component.set('v.caseObject',response.getReturnValue());
                
                if(response.getReturnValue().Status=='Escalated'){
                    component.set('v.escalatebuttonvariantname','success');
                    component.set('v.escalatebuttonlabel','Re-open');
                }
                else{
                    component.set('v.escalatebuttonvariantname','destructive');
                    component.set('v.escalatebuttonlabel','Escalate');
                }
            }
            else{
                console.log('Lochaaa');
            }
        });
    },
    updateCaseObjectHelper : function(component, event, helper) {
        console.log('i am from updateCaseObjectHelper');
        var action = component.get('c.escalateCaseRecords');
        action.setParams({"objCase" : component.get('v.caseObject')});
        action.setCallback(this, function(response){
            if(response.getState() ==='SUCCESS'){
                
                console.log(response.getReturnValue());
                component.set('v.caseObject',response.getReturnValue()); 
                
                
                if(response.getReturnValue().Status == 'Escalated'){
                    component.set('v.escalatebuttonvariantname', 'success'); 
                    component.set('v.escalatebuttonlabel', 'Re-Open');   
                }
                else{
                    component.set('v.escalatebuttonvariantname', 'destructive');
                    component.set('v.escalatebuttonlabel', 'Escalate');
                }
                
            }
            else{
                console.log('Locha...!!!');
            }
        });
        $A.enqueueAction(action);
    }
    
})