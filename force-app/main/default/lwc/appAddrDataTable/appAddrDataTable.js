import { LightningElement } from 'lwc';
import searchAddresses from '@salesforce/apex/CentralApplicantClass.searchAddresses';
import deleteAddresses from '@salesforce/apex/CentralApplicantClass.deleteAddresses';
import { ShowToastEvent } from 'lightning/platformShowToastEvent'; 

const  columns = [
    { label: 'Address Id', fieldName: 'Name', editable: true },
    { label: 'Country', fieldName: 'Country__c', editable: true },
    { label: 'State', fieldName: 'State__c', editable: true },
    { label: 'City', fieldName: 'City__c', editable: true }
  ];
  

export default class AppAddrDataTable extends LightningElement {

    applicantId
    addressList
    draftValues=[];
    columns = columns;
    selectedRecords
    selectedRecordsCount=0
    showSpinnerFlag=false

    searchAddressHandler(){   
        this.showSpinnerFlag=true;
        this.applicantId = this.template.querySelector('lightning-input[data-formfield="applicantId"] ').value;
        console.log('Address Record Searched Successfully='+this.applicantId);
    
        searchAddresses({ appName : this.applicantId})
        .then((result) => {
          this.result = result;
          this.error = undefined;
          console.log(this.result);
          this.addressList = result;
          this.showSuccessToast('Your Applicant Address Records is Searched');
          this.showSpinnerFlag=false;
    
      })
      .catch((error) => {
          this.error = error;
          this.result = undefined;
          console.log(this.error);
      });
    
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
  
      deleteSelectedAddressHandler(){
        let text;
        if (confirm("Do you really want to delete this record?..!") == true) {

            deleteAddresses({ adrList : this.selectedRecords})
            .then((result) => {
              this.result = result;
              this.error = undefined;
              console.log('Message = '+this.result);
              this.getRefreshData();
              this.showSuccessToast(result);
          })
          .catch((error) => {
              this.error = error;
              this.result = undefined;
              console.log('Message = '+this.error);
          });
    
        } else {
          text = "You canceled!";
        }
      }

      getRefreshData(){   
     
        searchAddresses({ appName : this.applicantId})
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

    showSuccessToast(myMessage) {
        const evt = new ShowToastEvent({
            title: 'Message',
            message: myMessage,
            variant: 'success',
            mode: 'dismissable'
        });
        this.dispatchEvent(evt);
    }
    
}