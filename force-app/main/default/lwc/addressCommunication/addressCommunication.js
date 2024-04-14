import { api, LightningElement } from 'lwc';

const  columns = [
    { label: 'Address ID', fieldName: 'Name', editable: true },
    { label: 'Country', fieldName: 'Country__c', editable: true },
    { label: 'State', fieldName: 'State__c', editable: true },
    { label: 'City', fieldName: 'City__c', editable: true }
  ];



export default class AddressCommunication extends LightningElement {

   @api receivedAdressList
   draftValues=[];
    columns = columns;

    selectedRecordsHandler(){

    }
}