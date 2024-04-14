import { LightningElement } from 'lwc';
import getAllAccountsType from '@salesforce/apex/CentralAccountClass.getAllAccountsType';
import DeleteSelectedAccounts from '@salesforce/apex/CentralAccountClass.DeleteSelectedAccounts';

import { ShowToastEvent } from 'lightning/platformShowToastEvent'; 

const  columns = [
   
    { label: 'Name', fieldName: 'Name', editable: true },
    { label: 'Type', fieldName: 'Type', editable: true },
    { label: 'Rating', fieldName: 'Rating', editable: true },
    { label: 'SLA', fieldName: 'SLA__c', editable: true }
  ];
  
export default class AccountDataTable extends LightningElement {

    selectedAccountType
    accList

    draftValues=[];
    columns = columns;
    selectedRecordsCount=0
    selectedRecords
    showTableFlag=false
    showSpinnerFlag=false


    get optionsType() {
        return [
            { label: 'Prospect', value: 'Prospect' },
            { label: 'Customer - Direct', value: 'Customer - Direct' },
            { label: 'Customer - Channel', value: 'Customer - Channel' },
            { label: 'Channel Partner / Reseller', value: 'Channel Partner / Reseller' },
            { label: 'Installation Partner', value: 'Installation Partner' },
            { label: 'Technology Partner', value: 'Technology Partner' },
            { label: 'Other', value: 'Other' },
    
        ];
    }
    
    handleChangeType(event) {
        this.selectedAccountType = event.detail.value;
        this.showSpinnerFlag=true

        getAllAccountsType({ accType : this.selectedAccountType})
    .then((result) => {
      this.accList = result;
      this.error = undefined;
      console.log(result)
      this.showSpinnerFlag=false
      this.showSuccessToast('Your Account Type is Searched..!!!')

      if(result.length > 0 ){
        this.showTableFlag = true
      }
      else{
        this.showTableFlag = false
      }
      

  })
  .catch((error) => {
      this.error = error;
      this.result = undefined;
      console.log(error)
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
  
      deleteSelectedRecordsHandler(){
        
        DeleteSelectedAccounts({ accIdList : this.selectedRecords})
    .then((result) => {
      this.resuly = result;
      this.error = undefined;
      this.showSuccessToast(result)
      this.getRefreshdata();

     

  })
  .catch((error) => {
      this.error = error;
      this.result = undefined;
  });
      }

      getRefreshdata() {
       
             getAllAccountsType({ accType : this.selectedAccountType})
    .then((result) => {
      this.accList = result;
      this.error = undefined;
      console.log(result)

     
  })
  .catch((error) => {
      this.error = error;
      this.result = undefined;
      console.log(error)
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