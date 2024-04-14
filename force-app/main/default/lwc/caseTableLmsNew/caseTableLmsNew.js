import { LightningElement, wire } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent' ; 
import getAllCaseStatus from '@salesforce/apex/CaseProvider.getAllCaseStatus';
import MYCHANNEL from "@salesforce/messageChannel/CaseDataChannel__c";
import {subscribe, MessageContext,APPLICATION_SCOPE} from "lightning/messageService"

const  columns = [
    { label: 'Case Number', fieldName: 'CaseNumber', editable: true },
    { label: 'Status', fieldName: 'Status', editable: true },
    { label: 'Type', fieldName: 'Type', editable: true },
    { label: 'Reason', fieldName: 'Reason', editable: true }
  ];


export default class CaseTableLmsNew extends LightningElement {
    @wire(MessageContext)
    context

    receivedCaseStatus
    showSpinnerFlag = false 
    caseTableList
    totalCases

    draftValues=[];
    columns = columns;
    selectedRecords
    selectedRecordsCount = 0

    connectedCallback(){
        this.receiveDataHandler()
    }

    receiveDataHandler(){
        subscribe(this.context, MYCHANNEL, (message)=>{this.handleMessageHandler(message)}, {scope : APPLICATION_SCOPE} )
    }

    handleMessageHandler(message){
            this.receivedCaseStatus = message.caseStatus.value

            this.showSpinnerFlag = true
            getAllCaseStatus({ caseStatus : this.receivedCaseStatus })
                .then((result) => {
                    console.log(result)
                    this.caseTableList = result;
                    this.error = undefined;
                    this.totalCases = this.caseTableList.length;
                    this.showSpinnerFlag = false
                    this.showSuccessToast();
                    
                })
                .catch((error) => {
                    console.log(error)
                    this.error = error;
                    this.result = undefined;
                });
    }

    showSuccessToast() {
        const evt = new ShowToastEvent({
            title: 'Message',
            message: 'Record fetched successfully',
            variant: 'success',
            mode: 'dismissable'
        });
        this.dispatchEvent(evt);
    }


    selectedRecordsHandler(event){
        const selectedRows  =   event.detail.selectedRows;
        console.log("Selected Rows = "+selectedRows)
        this.selectedRecordsCount = event.detail.selectedRows.length;
  
        let recordsSets = new Set();
  
        // getting selected record id
        for (let i = 0; i < selectedRows.length; i++) {
            recordsSets.add(selectedRows[i].Id);
        }
  
        // coverting to array
        this.selectedRecords = Array.from(recordsSets);
  
    }

}