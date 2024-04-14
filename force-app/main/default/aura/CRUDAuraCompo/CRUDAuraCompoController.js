({
    createAccountController : function(component, event, helper) {
        
        component.set('v.showSaveButton',true);
        component.set('v.showTypeFlag',true);
        component.set('v.showSearchNowButton',false);
        component.set('v.showUpdateNowButton',false);
        component.set('v.disableEditDelete',true);
    },
    searchAccountController : function(component, event, helper) {
        
        component.set('v.showSaveButton',false);
        component.set('v.showTypeFlag',false);
        component.set('v.showSearchNowButton',true);
        component.set('v.showUpdateNowButton',false);
        
        
        
    },
    updateAccountController : function(component, event, helper) {
        
        component.set('v.showSaveButton',false);
        component.set('v.showTypeFlag',true);
        component.set('v.showSearchNowButton',false);
        component.set('v.showUpdateNowButton',true);
        
    },
    deleteAccountController : function(component, event, helper) {
        let text="Do you really want to delete this record";
        if (confirm(text) == true) {
            helper.deleteAccountHelper(component, event, helper);
            component.set('v.showSaveButton',false);
            component.set('v.showSpinnerFlag',true);
           } 
        
    },
    saveAccountController : function(component, event, helper) {
        component.set('v.showSpinnerFlag',true);
        helper.saveAccountHelper(component, event, helper);
        
    },
    searchNowAccountController : function(component, event, helper) {
        helper.searchAccountHelper(component, event, helper);
        component.set('v.disableEditDelete',false);
        component.set('v.showSpinnerFlag',true);
        
        
    },
    updateNowAccountController : function(component, event, helper) {
        
        helper.updateAccountHelper(component, event, helper);
        component.set('v.showSpinnerFlag',true);
        
    }
})