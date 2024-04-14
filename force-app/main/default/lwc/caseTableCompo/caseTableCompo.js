import { api, LightningElement } from 'lwc';

const  columns = [
    { label: 'Case Number', fieldName: 'CaseNumber', editable: true },
    { label: 'Status', fieldName: 'Status', editable: true },
    { label: 'Priority', fieldName: 'Priority', editable: true },
    { label: 'Origin', fieldName: 'Origin', editable: true }
  ];


export default class CaseTableCompo extends LightningElement {

 @api caseStatusList
 draftValues=[];
 columns = columns;


 selectedRecordsHandler(){

 }



   
}