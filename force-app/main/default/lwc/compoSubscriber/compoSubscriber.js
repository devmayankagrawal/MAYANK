import { LightningElement } from 'lwc';
import compopubsubfile from 'c/compopubsubfile';

export default class CompoSubscriber extends LightningElement {

    receivedData ='Waiting for Data'

    connectedCallback(){
        this.receivedDataHandler();
    }

    receivedDataHandler(){
        compopubsubfile.subscribe("sendDataEvent", (message) => {
            this.receivedData = message
        });
    }
}