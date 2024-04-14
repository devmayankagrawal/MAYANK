import { LightningElement } from 'lwc';
import createAccountRecord from "@salesforce/apex/AccountProvider.createAccountRecord"

export default class AccountCompo extends LightningElement {
    objAccount = {'sobjectType' : 'Account'}

    saveButtonHandler(){
        this.objAccount.Name = this.template.querySelector('lightning-input[data-formfield="accountName"]').value;
        this.objAccount.Type = this.template.querySelector('lightning-input[data-formfield="accountType"]').value;
        this.objAccount.SLA__c = this.template.querySelector('lightning-input[data-formfield="accountSLA"]').value;
        this.objAccount.Rating = this.template.querySelector('lightning-input[data-formfield="accountRating"]').value;



        createAccountRecord({ objAcc : this.objAccount})
        .then((result) => {
          this.result = result;
          this.error = undefined;
      })
      .catch((error) => {
          this.error = error;
          this.result = undefined;
      });
  
    }
    get options() {
        return [
            { label: 'Hot', value: 'Hot' },
            { label: 'Warm', value: 'Warm' },
            { label: 'Cold', value: 'Cold' },
        ];
    }

    handleRating(event) {
        console.log(event.detail.value);
        this.objAccount.Rating = event.detail.value;
    }


}