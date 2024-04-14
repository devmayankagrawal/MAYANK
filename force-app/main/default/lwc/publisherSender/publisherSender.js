import { LightningElement } from 'lwc';
import pubsubSenderReceiver from 'c/pubsubSenderReceiver';

export default class PublisherSender extends LightningElement {

    accountName

    sendDataHandler(){
       this.accountName = this.template.querySelector('lightning-input[data-formfield="accountName"]').value;

       pubsubSenderReceiver.publish("sendDataEvent" , this.accountName);
    }
}