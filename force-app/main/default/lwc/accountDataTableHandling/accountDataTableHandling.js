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
  

export default class AccountDataTableHandling extends LightningElement {

    selectedAccType
    accList

    draftValues=[];
    columns = columns;
    selectedRecords
    selectedRecordsCount=0


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
       
        this.selectedAccType = event.detail.value;
        console.log(event.detail.value);

        getAllAccountsType({ accType : this.selectedAccType})
    .then((result) => {
      this.accList = result;
       this.error = undefined;
      console.log(this.accList);
      this.showSuccessToast('Your Account Type is Searched');

  })
  .catch((error) => {
      this.error = error;
      this.result = undefined;

      this.showTableFlag=false
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

    selectedRecordsHandler(event){
        const selectedRows  =   event.detail.selectedRows;
        console.log("Selected Rows = "+JSON.stringify(selectedRows))
        this.selectedRecordsCount = event.detail.selectedRows.length;
  
        let recordsSets = new Set();
  
        // getting selected record id
        for (let i = 0; i < selectedRows.length; i++) {
            recordsSets.add(selectedRows[i].Id);
        }
  
        // coverting to array
        this.selectedRecords = Array.from(recordsSets);
      }

      DeleteSelectedRecordsHandler(){

        let text;
        if (confirm("Do you really want to delete this record?..!") == true) {

            DeleteSelectedAccounts({ accIdList : this.selectedRecords})
            .then((result) => {
              this.result = result;
              this.error = undefined;
              console.log('Message = '+this.result);
              this.showSuccessToast(result);
              this.getRefreshData();
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
  
      getRefreshData() {
       
        getAllAccountsType({ accType : this.selectedAccType})
    .then((result) => {
      this.accList = result;
       this.error = undefined;
      console.log(this.accList);
      this.showSuccessToast('Your Account Type is Refreshed');

  })
  .catch((error) => {
      this.error = error;
      this.result = undefined;

      this.showTableFlag=false
  });
    }
 
}