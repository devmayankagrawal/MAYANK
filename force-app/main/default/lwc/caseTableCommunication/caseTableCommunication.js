import { api, LightningElement } from 'lwc';

const  columns = [
    { label: 'Case Number', fieldName: 'CaseNumber', editable: true },
    { label: 'Status', fieldName: 'Status', editable: true },
    { label: 'Priority', fieldName: 'Priority', editable: true },
    { label: 'Origin', fieldName: 'Origin', editable: true }
  ];

export default class CaseTableCommunication extends LightningElement {

    @api receivedCaseList
    draftValues=[];
 columns = columns;


 selectedRecordsHandler(){

 }

}