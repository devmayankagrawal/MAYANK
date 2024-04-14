import { LightningElement } from 'lwc';
import createAccountRecord from '@salesforce/apex/AccountProvider.createAccountRecord'
import { ShowToastEvent } from 'lightning/platformShowToastEvent' ; 
import searchAccount from '@salesforce/apex/AccountProvider.searchAccount'
import updateAccount from '@salesforce/apex/AccountProvider.updateAccount'
import deleteAccount from '@salesforce/apex/AccountProvider.deleteAccount'
import undeleteAccount from '@salesforce/apex/AccountProvider.undeleteAccount'

export default class CrudCompo extends LightningElement {
    accountObject = {'sobjectType' : 'Account'}
    result
    error
    showSpinnerFlag = false

    createAccountHandler(event){
        eval("$A.get('e.force:refreshView').fire();");


        this.accountObject.Name = this.template.querySelector('lightning-input[data-formfield="accountName"]').value
        this.accountObject.Type = this.template.querySelector('lightning-input[data-formfield="accountType"]').value
        this.accountObject.Rating = this.template.querySelector('lightning-input[data-formfield="accountRating"]').value
        this.accountObject.SLA__c = this.template.querySelector('lightning-input[data-formfield="accountSLA"]').value
   
        
        createAccountRecord({ objAcc : this.accountObject})
        .then((result) => {
          this.result = result;
          this.error = undefined;
          this.showSuccessToast();
      })
      .catch((error) => {
          this.error = error;
          this.result = undefined;
          console.log("Message = "+this.error);
      });

      

   
    }

    searchAccountHandler(){
        this.showSpinnerFlag = true

        this.accountObject.Name = this.template.querySelector('lightning-input[data-formfield="accountName"]').value
        

        searchAccount({ objAcc : this.accountObject})
        .then((result) => {
          this.accountObject = result;
          this.showSuccessToast();
          this.showSpinnerFlag = false
      })
      .catch((error) => {
          this.error = error;
          this.result = undefined;
          console.log("Message = "+this.error);
      });


    }


    updateAccountHandler(){
        this.accountObject.Name = this.template.querySelector('lightning-input[data-formfield="accountName"]').value
        this.accountObject.Type = this.template.querySelector('lightning-input[data-formfield="accountType"]').value
        this.accountObject.Rating = this.template.querySelector('lightning-input[data-formfield="accountRating"]').value
        this.accountObject.SLA__c = this.template.querySelector('lightning-input[data-formfield="accountSLA"]').value
  

        updateAccount({ objAcc : this.accountObject})
        .then((result) => {
          this.result = result;
          this.showSuccessToast();
      })
      .catch((error) => {
          this.error = error;
          this.result = undefined;
          console.log("Message = "+this.error);
      });

    }

    deleteAccountHandler(){
        let text;
if (confirm("Do you really want to delete this record??...") == true) {
                deleteAccount({ objAcc : this.accountObject})
                .then((result) => {
                this.accountObject = result;
                this.showSuccessToast();
            })
            .catch((error) => {
                this.error = error;
                this.result = undefined;
                console.log("Message = "+this.error);
            });

}

 else {
  text = "You canceled!";
}

    }

    undeleteAccountHandler(){

        this.accountObject.Name = this.template.querySelector('lightning-input[data-formfield="accountName"]').value
       
        undeleteAccount({ objAcc : this.accountObject})
        .then((result) => {
          this.accountObject = result;
          this.showSuccessToast();
      })
      .catch((error) => {
          this.error = error;
          this.result = undefined;
          console.log("Message = "+this.error);
      });
    

    }

    showSuccessToast() {
        const evt = new ShowToastEvent({
            title: 'Message',
            message: this.result,
            variant: 'success',
            mode: 'dismissable'
        });
        this.dispatchEvent(evt);
    }


}