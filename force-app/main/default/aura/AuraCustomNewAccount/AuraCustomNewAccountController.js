({
	createNewAccountController : function(component, event, helper) {
		console.log('I am from JS controller Method');
        
        helper.createNewAccountHelper(component, event, helper);
	},
    
    checkAccountDetailsController : function(component, event, helper) {
        var accountId = component.find('accountNameId');   
        var accountName =accountId.get('v.value'); 
        
        console.log("Account Name " +accountName);
        
        //Try : Account Name should not contain any digit or special symbol
        if(accountName.length < 3){
            accountId.setCustomValidity("Account Name must be of minimum 03 characters");
            component.set('v.showingError', true);
        }
        else{
           accountId.setCustomValidity("");
            component.set('v.showingError', false);
        }
        accountId.reportValidity();

    }
})