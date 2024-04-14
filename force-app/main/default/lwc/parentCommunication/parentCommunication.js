import { LightningElement, track } from 'lwc';

export default class ParentCommunication extends LightningElement {

    salary=100
    empoyeeName='Pushpa'

    @track objAccount = {'sobjectType' : 'Account'}

    Car={

        Make : 'Honda',
        Model : 'City'
    }

    sendAccountName(){
        this.objAccount.Name = this.template.querySelector('lightning-input[data-formfield="accountName"]').value;
    }
}