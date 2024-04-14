import { LightningElement } from 'lwc';
import pubsubSenderReceiver from 'c/pubsubSenderReceiver';

export default class SubscriberReceiver extends LightningElement {

    receivedData = "Waiting for Data..."

    connectedCallback(){
        this.receivedDataHandler()
    }

    receivedDataHandler(){
        pubsubSenderReceiver.subscribe("sendDataEvent" , (message) => {
            this.receivedData = message
         });
 
    }
}