import { LightningElement } from 'lwc';
import pubsubfile from 'c/pubsubfile';

export default class PublisherCompo extends LightningElement {

    accountName

    sendDataHandler(){

       this.accountName = this.template.querySelector('lightning-input[data-formfield="accountName"]').value;
        pubsubfile.publish("sendDataEvent",this.accountName);

    }
}