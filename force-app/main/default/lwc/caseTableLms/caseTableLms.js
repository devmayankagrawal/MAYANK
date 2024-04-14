import { LightningElement, wire } from 'lwc';
import MYCHANNEL from "@salesforce/messageChannel/CaseStatusChannel__c";
import {subscribe, MessageContext,APPLICATION_SCOPE} from "lightning/messageService"

const  columns = [
    { label: 'CaseNumber', fieldName: 'CaseNumber', editable: true },
    { label: 'Status', fieldName: 'Status', editable: true },
    { label: 'Priority', fieldName: 'Priority', editable: true },
    { label: 'Origin', fieldName: 'Origin', editable: true },
    { label: 'Type', fieldName: 'Type', editable: true }
  ];

export default class CaseTableLms extends LightningElement {
    @wire(MessageContext)
    context
    draftValues=[];
    columns = columns;
    
    receivedStatus

   

    connectedCallback(){
        this.receiveDataHandler()
}

receiveDataHandler(){
    subscribe(this.context, MYCHANNEL, (message)=>{this.handleMessageHandler(message)}, {scope : APPLICATION_SCOPE} )
}

handleMessageHandler(message){
    console.log("Received Data = "+message.caseStatus.value);
   this.receivedStatus = message.caseStatus.value
}

     
selectedRecordsHandler(){
            
}



}