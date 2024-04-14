import { LightningElement } from 'lwc';
import getAllAccountsType from '@salesforce/apex/AccountProvider.getAllAccountsType'
import deleteSelectedAccounts from '@salesforce/apex/AccountProvider.deleteSelectedAccounts'

const  columns = [
    { label: 'Enter Account Name', fieldName: 'Name', editable: true },
    { label: 'Type', fieldName: 'Type', editable: true },
    { label: 'SLA', fieldName: 'SLA__c', editable: true },
  ];
  

export default class DataTableAccountCompo extends LightningElement {

    selectedAccountType
    accList
    showTableFlag=false
    totalRecords

    draftValues=[];
    columns = columns;
    selectedRecordsCount
    selectedRecords



    get accTypes() {
        return [
            { label: 'Prospect', value: 'Prospect' },
            { label: 'In Customer - Direct', value: 'Customer - Direct' },
            { label: 'Customer - Channel', value: 'Customer - Channel' },
            { label: 'Channel Partner / Reseller', value: 'Channel Partner / Reseller' },
            { label: 'Installation Partner', value: 'Installation Partner' },
            { label: 'Technology Partner', value: 'Technology Partner' },
            { label: 'Other', value: 'Other' },
     
        ];
    }

    handleAccountTypeChange(event) {
        this.selectedAccountType = event.detail.value;
        
        getAllAccountsType({ accType : this.selectedAccountType})
        .then((result) => {
            
            console.log(result);
          this.accList = result;
          this.result = result;
          this.error = undefined;

        
      })
      .catch((error) => {
          console.log(error)
          this.error = error;
          this.result = undefined;
         
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
  
      deleteSelectedRecordsHandler(){

        deleteSelectedAccounts({ accIDList : this.selectedRecords})
        .then((result) => {
            
          this.result = result;
          this.error = undefined;
          console.log('Message = '+this.result);
         this.getRefreshData();

        
      })
      .catch((error) => {
          
          this.error = error;
          this.result = undefined;
          console.log('Message = '+this.error);
         
         
      });
  

      }
      getRefreshData() {
        
        
        getAllAccountsType({ accType : this.selectedAccountType})
        .then((result) => {
            
            console.log(result);
          this.accList = result;
          this.result = result;
          this.error = undefined;

        
      })
      .catch((error) => {
          console.log(error)
          this.error = error;
          this.result = undefined;
         
      });
  
    }
}