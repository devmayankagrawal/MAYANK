import { LightningElement } from 'lwc';
import pubsubappadr from 'c/pubsubappadr';

const  columns = [
    { label:'Address ID', fieldName:'Name', editable:true},
    { label:'Country', fieldName:'Country__c', editable:true},    
    { label:'State', fieldName:'State__c', editable:true},
    { label:'City', fieldName:'City__c', editable:true}

    ];

export default class AddrSub extends LightningElement {


    draftValues=[];
    columns = columns;
    receivedAddressList

    connectedCallback(){
        this.receivedDataHandler()
    }
    receivedDataHandler(){
        pubsubappadr.subscribe("sendDataEvent", (message) =>{
            this.receivedAddressList = message
        });
    }

    selectedRecordsHandler(){
        
    }
}