import { LightningElement, api } from 'lwc';
const  columns = [
    { label: 'Enter Address ID', fieldName: 'Name', editable: true },
    { label: 'Country', fieldName: 'Country__c', editable: true },
    { label: 'State', fieldName: 'State__c', editable: true },
    { label: 'City', fieldName: 'City__c', editable: true }
 
  ];

export default class Tax extends LightningElement {

    @api productAddressList
    draftValues=[];
    columns = columns;

    selectedRecordsHandler(){
        
    }
}