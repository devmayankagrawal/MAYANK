import { LightningElement } from 'lwc';
import caseStatusPubsub from 'c/caseStatusPubsub';

const  columns = [
    { label: 'Case Number', fieldName: 'CaseNumber', editable: true },
    { label: 'Status', fieldName: 'Status', editable: true },
    { label: 'Priority', fieldName: 'Priority', editable: true },
    { label: 'Origin', fieldName: 'Origin', editable: true }
  ];

export default class CaseTableSubscriber extends LightningElement {

    receivedCaseData
    draftValues=[];
 columns = columns;


    connectedCallback(){
        this.receivedDataHandler()
    }

    receivedDataHandler(){
        caseStatusPubsub.subscribe("sendDataEvent" , (message) => {
           this.receivedCaseData = message
        });
    }
    selectedRecordsHandler(){
        
    }
}