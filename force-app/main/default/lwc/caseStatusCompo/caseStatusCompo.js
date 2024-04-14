import { LightningElement, track } from 'lwc';
import getAllCaseStatus from '@salesforce/apex/CaseProvider.getAllCaseStatus'

export default class CaseStatusCompo extends LightningElement {

    selectedCaseStatus
    caseList
    totalRecords
   
    showSpinnerFlag

    get caseStatuses() {
        return [
             { label: 'New', value: 'New' },
             { label: 'Working', value: 'Working' },
             { label: 'Escalated', value: 'Escalated' },
             { label: 'Closed', value: 'Closed' },

        ];
    }

   

    handleCaseStatusChange(event){
        this.selectedCaseStatus = event.detail.value;
        console.log(this.selectedCaseStatus);
        
        getAllCaseStatus({caseStatus : this.selectedCaseStatus})
        .then((result) => {

            this.showSpinnerFlag = true;
            this.result = result;
            this.error = undefined;
            console.log(JSON.stringify(result));
            this.caseList = result;
            this.totalRecords = result.length
          this.showSpinnerFlag = false;
          this.showSuccessToast();
        })
        .catch((error) => {
            this.error = error;
            this.result = undefined;
            console.log(this.error);
        });
   
         
    }
    showSuccessToast() {
        const evt = new ShowToastEvent({
            title: 'Message',
            message: this.result,
            variant: 'success',
            mode: 'dismissable'
        });
        this.dispatchEvent(evt);
    }

 showSuccessToast() {
        const evt = new ShowToastEvent({
            title: 'Message',
            message: this.result,
            variant: 'success',
            mode: 'dismissable'
        });
        this.dispatchEvent(evt);
    }
 
}