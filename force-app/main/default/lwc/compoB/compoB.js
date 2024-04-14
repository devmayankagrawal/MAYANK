import { LightningElement, wire } from 'lwc';
import MYCHANNEL from "@salesforce/messageChannel/AccountDataChannel__c";
import {subscribe, MessageContext,APPLICATION_SCOPE} from "lightning/messageService"



export default class CompoB extends LightningElement {

    @wire(MessageContext)
    context


    receivedName

    connectedCallback(){
        this.receiveDataHandler()
}

receiveDataHandler(){
    subscribe(this.context, MYCHANNEL, (message)=>{this.handleMessage(message)}, {scope : APPLICATION_SCOPE} )
}

handleMessage(message){
   this.receivedName = message.accountName.value
}

}