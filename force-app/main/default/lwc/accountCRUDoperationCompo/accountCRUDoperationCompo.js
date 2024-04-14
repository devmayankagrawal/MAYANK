import { LightningElement } from 'lwc';
import createAccountRecordData from '@salesforce/apex/AccountCentralClass.createAccountRecordData';
import searchAccountRecord from '@salesforce/apex/AccountCentralClass.searchAccountRecord';
import updateAccountRecord from '@salesforce/apex/AccountCentralClass.updateAccountRecord';
import deleteAccountRecord from '@salesforce/apex/AccountCentralClass.deleteAccountRecord';
import undeleteAccountRecord from '@salesforce/apex/AccountCentralClass.undeleteAccountRecord';
import { ShowToastEvent } from 'lightning/platformShowToastEvent' ; 

export default class AccountCRUDoperationCompo extends LightningElement {

    objAccount = {'sobjectType' : 'Account'}
    showSpinnerFlag=false
    

    get optionsType() {
        return [
            { label: 'Prospect', value: 'Prospect' },
            { label: 'Customer - Direct', value: 'Customer - Direct' },
            { label: 'Customer - Channel', value: 'Customer - Channel' },
            { label: 'Channel Partner / Reseller', value: 'Channel Partner / Reseller' },
            { label: 'Installation Partner', value: 'Installation Partner' },
            { label: 'Technology Partner', value: 'Technology Partner' },
            { label: 'Other', value: 'Other' },
        ];
    }

    handleChangeType(event) {
        this.objAccount.Type = event.detail.value;
    }

    get optionsRating() {
        return [
            { label: 'Hot', value: 'Hot' },
            { label: 'Warm', value: 'Warm' },
            { label: 'Cold', value: 'Cold' },
        ];
    }

    handleChangeRating(event) {
        this.objAccount.Rating = event.detail.value;
    }

    get optionsSLA() {
        return [
            { label: 'Gold', value: 'Gold' },
            { label: 'Silver', value: 'Silver' },
            { label: 'Platinum', value: 'Platinum' },
            { label: 'Bronze', value: 'Bronze' },
        ];
    }

    handleChangeSLA(event) {
        this.objAccount.SLA__c = event.detail.value;
    }


    accountRecordCreateHandler(event){

        eval("$A.get('e.force:refreshView').fire();");



        this.objAccount.Name =  this.template.querySelector('lightning-input[data-formfield="accountName"]').value;
     console.log('Account Created Successfully = '  +this.objAccount.Name)

     createAccountRecordData({ objAcc : this.objAccount})
     .then((result) => {
       this.objAccount = result;
       this.error = undefined;
       this.showSuccessToast(result);
   })
   .catch((error) => {
       this.error = error;
       this.result = undefined;
   });

    }
    accountRecordSearchHandler(){
        this.showSpinnerFlag=true

        this.objAccount.Name =  this.template.querySelector('lightning-input[data-formfield="accountName"]').value;
        console.log('Account Searched Successfully = '  +this.objAccount.Name)
   
        searchAccountRecord({ objAcc : this.objAccount})
        .then((result) => {
          this.objAccount = result;
          this.error = undefined;
          this.showSuccessToast('Your Account record is searched');
          this.showSpinnerFlag=false
      })
      .catch((error) => {
          this.error = error;
          this.result = undefined;
          console.log('Message = '+this.error);
      });

    }
    accountRecordUpdateHandler(){
        this.objAccount.Name =  this.template.querySelector('lightning-input[data-formfield="accountName"]').value;
        console.log('Account Updated Successfully = '  +this.objAccount.Name)
   
        updateAccountRecord({ objAcc : this.objAccount})
        .then((result) => {
          this.objAccount = result;
          this.error = undefined;
          this.showSuccessToast(result);
      })
      .catch((error) => {
          this.error = error;
          this.result = undefined;
      });

    }
    accountRecordDeleteHandler(){
        let text;
        if (confirm("Do you really want to delete this record?..!") == true) {

            deleteAccountRecord({ objAcc : this.objAccount})
            .then((result) => {
              this.objAccount = result;
              this.error = undefined;
              this.showSuccessToast(result);
          })
          .catch((error) => {
              this.error = error;
              this.result = undefined;
              console.log('Message = '+this.error);
          });
    
        } else {
          text = "You canceled!";
        }
        

    }
    accountRecordUndeleteHandler(){
        this.objAccount.Name =  this.template.querySelector('lightning-input[data-formfield="accountName"]').value;
   

        undeleteAccountRecord({ objAcc : this.objAccount})
        .then((result) => {
          this.objAccount = result;
          this.error = undefined;
          this.showSuccessToast(result);
      })
      .catch((error) => {
          this.error = error;
          this.result = undefined;
          console.log('Message = '+this.error);
      });

    }
    showSuccessToast(myMessage) {
        const evt = new ShowToastEvent({
            title: 'Message',
            message: myMessage,
            variant: 'success',
            mode: 'dismissable'
        });
        this.dispatchEvent(evt);
    }

}