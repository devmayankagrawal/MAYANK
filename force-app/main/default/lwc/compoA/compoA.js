import { LightningElement, wire } from 'lwc';
import MYCHANNEL from "@salesforce/messageChannel/AccountDataChannel__c";
import {publish, MessageContext} from "lightning/messageService"



export default class CompoA extends LightningElement {

    @wire(MessageContext)
    context


    accName


    sendAccountData(){
       this.accName =  this.template.querySelector('lightning-input[data-formfield="accountName"]').value;

       const message={
        accountName:{
            value:this.accName
        }
     }

     publish(this.context, MYCHANNEL, message);

}

    
}