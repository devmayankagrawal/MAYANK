import { api, LightningElement } from 'lwc';
import appAddrPubsub from 'c/appAddrPubsub';


const  columns = [    
    { label: 'Address ID', fieldName: 'Name', editable: true },
    { label: 'Address Line 1', fieldName: 'Address_Line_1__c', editable: true },
    { label: 'Country', fieldName: 'Country__c', editable: true },
    { label: 'State', fieldName: 'State__c', editable: true },
    { label: 'City', fieldName: 'City__c', editable: true },
];


export default class AddressSubscriber extends LightningElement {

   @api receivedData = 'Waiting For Dataaaa,,,,,'
    draftValues=[];
    columns = columns;
    selectedRecordsCount

    


    connectedCallback(){
        this.receivedDataHandler()
    }

    receivedDataHandler(){
        appAddrPubsub.subscribe("sendDataEvent" , (message) => {
            this.receivedData = message
         });
        }
        selectedRecordsHandler(){
           
          }
      
}