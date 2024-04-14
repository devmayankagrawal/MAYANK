import { LightningElement, wire } from 'lwc';
import MYCHANNEL from "@salesforce/messageChannel/AccountDataChannel__c";
import {publish, MessageContext} from "lightning/messageService"



export default class Guru extends LightningElement {

    @wire(MessageContext)
    context

    accName

    sendDataToChelaHandler(){
        this.accName = this.template.querySelector('lightning-input[data-formfield="accName"]').value;

        const message={
            accountName:{
                value:this.accName
            }
         }
    
         publish(this.context, MYCHANNEL, message);

    }
}