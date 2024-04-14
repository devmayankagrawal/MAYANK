import { LightningElement } from 'lwc';
import createAccountRecord from '@salesforce/apex/CentralAccountClass.createAccountRecord';

export default class CreateAccount extends LightningElement {

objAccount = {'sobjectType' : 'Account'}

saveButtonHandler(){
  this.objAccount.Name = this.template.querySelector('lightning-input[data-formfield="accountName"]').value;
    console.log(this.objAccount.Name);

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
    console.log(this.objAccount.Type);
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
    console.log(this.objAccount.Rating);
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
    console.log(this.objAccount.SLA__c);
}






}