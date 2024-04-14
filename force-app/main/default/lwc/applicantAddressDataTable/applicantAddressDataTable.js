import { LightningElement } from 'lwc';
import searchAddresses from '@salesforce/apex/ApplicantProvider.searchAddresses'
import deleteAddresses from '@salesforce/apex/ApplicantProvider.deleteAddresses'

const  columns = [
    { label: 'Enter Address ID', fieldName: 'Name', editable: true },
    { label: 'Country', fieldName: 'Country__c', editable: true },
    { label: 'State', fieldName: 'State__c', editable: true },
    { label: 'City', fieldName: 'City__c', editable: true }
 
  ];

export default class ApplicantAddressDataTable extends LightningElement {

    applicantId
    addressList
    draftValues=[];
    columns = columns;
    selectedRecordsCount

    searchAddressHandler(){
        this.applicantId = this.template.querySelector('lightning-input[data-formfield="applicantID"]').value
        console.log(this.applicantId);
       
        searchAddresses({appName : this.applicantId})
        .then((result) => {
            
            this.result = result;
            this.error = undefined;
            console.log(this.result);
            this.addressList = result;
        })
        .catch((error) => {
            this.error = error;
            this.result = undefined;
            console.log(this.error);
        });
   
    }
    selectedRecordsHandler(event){
        const selectedRows  =   event.detail.selectedRows;
        console.log("Selected Rows = "+ JSON.stringify(selectedRows))
        this.selectedRecordsCount = event.detail.selectedRows.length;
  
        let recordsSets = new Set();
  
        // getting selected record id
        for (let i = 0; i < selectedRows.length; i++) {
            recordsSets.add(selectedRows[i].Id);
        }
  
        // coverting to array
        this.selectedRecords = Array.from(recordsSets);
      }

      deleteSelectedAddressHandler(){
       
       
        deleteAddresses({adrIDList : this.selectedRecords})
        .then((result) => {
            
            this.result = result;
            this.error = undefined;
            console.log(this.result);
            this.getRefreshData();

            
        })
        .catch((error) => {
            this.error = error;
            this.result = undefined;
            console.log(this.error);
        });
   
    }

    getRefreshData(){
        
        
        searchAddresses({appName : this.applicantId})
        .then((result) => {
            
            this.result = result;
            this.error = undefined;
            console.log(this.result);
            this.addressList = result;
        })
        .catch((error) => {
            this.error = error;
            this.result = undefined;
            console.log(this.error);
        });
   
    }
}