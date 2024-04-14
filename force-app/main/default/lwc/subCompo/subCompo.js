import { LightningElement } from 'lwc';
import pubsubcompo from 'c/pubsubcompo';

export default class SubCompo extends LightningElement {

    receivedData

    connectedCallback(){
        this.receivedDataHandler()
    }
    receivedDataHandler(){
        pubsubcompo.subscribe("sendDataEvent", (message) =>{
            this.receivedData = message
        });
    }
}