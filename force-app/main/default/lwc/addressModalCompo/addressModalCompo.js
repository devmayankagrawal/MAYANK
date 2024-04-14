import { LightningElement, track } from 'lwc';


const  columns = [
    { label: 'Enter Address ID', fieldName: 'Name', editable: true },
    { label: 'Country', fieldName: 'Country__c', editable: true },
    { label: 'State', fieldName: 'State__c', editable: true },
    { label: 'City', fieldName: 'City__c', editable: true }
 
  ];

export default class AddressModalCompo extends LightningElement {
    draftValues=[];
    columns = columns;
    selectedRecordsCount
    @track objApplicant = {'sobjectType' : 'Applicant__c'}

    closeButtonHandler(){
        const myAddressEvent = new CustomEvent("myeventaddress", {detail : this.objApplicant});
        this.dispatchEvent(myAddressEvent);
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

}