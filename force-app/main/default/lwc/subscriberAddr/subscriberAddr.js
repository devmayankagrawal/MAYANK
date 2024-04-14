import { api, LightningElement } from 'lwc';
import pubsubappaddr from 'c/pubsubappaddr';

const  columns = [
    { label: 'Address ID', fieldName: 'Name', editable: true },
    { label: 'Country', fieldName: 'Country__c', editable: true },
    { label: 'State', fieldName: 'State__c', editable: true },
    { label: 'City', fieldName: 'City__c', editable: true }
  ];

export default class SubscriberAddr extends LightningElement {

    
    @api receivedAdressList
   draftValues=[];
    columns = columns;

   

    connectedCallback(){
        this.receiveDataHandler();
    }

    receiveDataHandler(){
        pubsubappaddr.subscribe("sendDataEvent", (message)=>{
         this.receivedAdressList =  message
        });
    }

    selectedRecordsHandler(){

    }



}