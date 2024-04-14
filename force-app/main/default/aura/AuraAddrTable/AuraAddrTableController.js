({
	receiveDataController : function(component, event, helper) {
		
        component.set('v.addressTablecolumns', [
            {label: 'Address ID', fieldName: 'Name', type: 'text'},
            {label: 'Country', fieldName: 'Country__c', type: 'text'},
            {label: 'State', fieldName: 'State__c', type: 'text'},
            {label: 'City', fieldName: 'City__c', type: 'text'}
        ]);

        console.log('Zatka laga....');
        
        var receivedData = event.getParam('AppAdrEventAddressList');
        console.log('received data='+JSON.stringify(receivedData));
        component.set('v.receivedAddressList',receivedData);
        component.set('v.receivedAppObject',event.getParam('eventAppObject'));
        component.set('v.totalRecords',receivedData.length);
	},
    
            selectedAddressRows :  function(component, event, helper) {
        var selectedAddressRows =  event.getParam('selectedRows');// Array
        console.log("Count = "+selectedAddressRows.length);        
        component.set('v.selectedRecordCount', selectedAddressRows.length);    
        
        var selectedAdrRows=[];
         for(var i=0; i<selectedAddressRows.length; i++){
            selectedAdrRows.push(selectedAddressRows[i]);
        }
        
        component.set('v.selectedAddressRecordList', selectedAdrRows); 
        
        
      
    },
    
    deleteSelectedAddressController : function(component, event, helper) {
        helper.deleteSelectedAddressesHelper(component, event, helper);
        console.log('i am from JS controller');
    }

})