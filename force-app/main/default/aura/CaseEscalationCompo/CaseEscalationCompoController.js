({
    showCaseDetailsController : function(component, event, helper) {
        helper.showCaseDetailsHelper(component, event, helper);
        component.set('v.showEscalateButton',true);
    },
    
    handlePopupController : function(component, event, helper) {
        var clickedButtonName =event.getSource('').get('v.label');
        console.log(clickedButtonName);
        
        if(clickedButtonName=='Escalate'){
            component.set('v.showPopupModal',true);
        }
        else{
            component.set('v.showPopupModal',false);
            helper.reOpenCaseHelper(component, event, helper);
        }
    },
    
    updateCaseObjectController : function(component, event, helper){
        
        console.log('I am from updateCaseObjectController');
        
        var receivedCaseObject = event.getParam("CaseObjectEvent");
        var receivedShowPopupFlag = event.getParam("showPopupModalFlagEvent");
        console.log(receivedCaseObject + '' +receivedShowPopupFlag);
        
        component.set('v.showPopupModal',receivedShowPopupFlag);
        component.set('v.caseObject',receivedCaseObject);
        
        helper.updateCaseObjectHelper(component, event, helper);
            

    }
})