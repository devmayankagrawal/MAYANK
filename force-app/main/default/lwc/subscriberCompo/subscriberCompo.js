import { LightningElement } from 'lwc';
import pubsubfile from 'c/pubsubfile';

export default class SubscriberCompo extends LightningElement {


    receivedAccountName = 'Waiting for Data....'

        connectedCallback(){
            this.receiveDataHandler();
        }

        receiveDataHandler(){
            pubsubfile.subscribe('sendDataEvent', (message)=>{
                this.receivedAccountName = message
            })
        }





}