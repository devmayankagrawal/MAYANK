({
    doInit : function(component, event, helper) {
        helper.fetchAllAplicantHelper(component, event, helper);
        
        component.set('v.appTableColList', [
            {label: 'ID', fieldName: 'Name', type: 'text'},
            {label: 'First Name', fieldName: 'First_Name__c', type: 'text'},
            {label: 'Last Name', fieldName: 'Last_Name__c', type: 'text'},
            {label: 'Gender', fieldName: 'Gender__c', type: 'text'}
        ]);
        
    }
})