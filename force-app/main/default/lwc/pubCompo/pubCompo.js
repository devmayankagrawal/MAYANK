import { LightningElement } from 'lwc';
import pubsubcompo from 'c/pubsubcompo';

export default class PubCompo extends LightningElement {

    accountName

    sendDataHandler(){
        this.accountName = this.template.querySelector('lightning-input[data-formfield="accountName"]').value;
        pubsubcompo.publish("sendDataEvent", this.accountName);
    }
}