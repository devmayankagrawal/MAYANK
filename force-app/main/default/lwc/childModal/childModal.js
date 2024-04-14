import { LightningElement, api } from 'lwc';
const  columns = [    
    { label: 'Address ID', fieldName: 'Name', editable: true },
    { label: 'Address Line 1', fieldName: 'Address_Line_1__c', editable: true },
    { label: 'Country', fieldName: 'Country__c', editable: true },
    { label: 'State', fieldName: 'State__c', editable: true },
    { label: 'City', fieldName: 'City__c', editable: true },
];

export default class ChildModal extends LightningElement {

    @api applicantAddressList
    draftValues=[];
    columns = columns;

    selectedRecordsHandler(){

    }

    closeButtonHandler(){
        const myChildEvent = new CustomEvent("myeventchild", {detail : false});
        this.dispatchEvent(myChildEvent);
    }
}