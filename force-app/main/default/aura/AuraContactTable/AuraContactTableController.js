({
	receiveDataController : function(component, event, helper) {
		
        component.set('v.contactTablecolumns', [
            {label: 'Contact First Name', fieldName: 'FirstName', type: 'text'},
            {label: 'Contact Last Name', fieldName: 'LastName', type: 'text'},
            {label: 'Level', fieldName: 'Level__c', type: 'text'},
            {label: 'Lead Source', fieldName: 'LeadSource', type: 'text'}
        ]);

        console.log('Zatka laga....');
        
        var receivedData = event.getParam('AccConEventContactList');
        console.log('received data='+JSON.stringify(receivedData));
        component.set('v.accountObject',receivedData);
        
        helper.showContactsHelper(component, event, helper);
	},
    
    selectedContactRows :  function(component, event, helper) {
        var selectedContactRows =  event.getParam('selectedRows');// Array
        console.log("Count = "+selectedContactRows.length);        
        component.set('v.selectedRecordCount', selectedContactRows.length);    
        
        var selectedConRows=[];
         for(var i=0; i<selectedContactRows.length; i++){
            selectedConRows.push(selectedContactRows[i]);
        }
        
        component.set('v.selectedContactRecordList', selectedConRows); 
    },
    
    deleteSelectedContactsController : function(component, event, helper){
        helper.deleteSelectedContactsHelper(component, event, helper);
    }
})