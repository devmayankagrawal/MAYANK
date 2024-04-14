import { LightningElement } from 'lwc';
import getCaseStatus from '@salesforce/apex/CaseProvider.getCaseStatus';
import { ShowToastEvent } from 'lightning/platformShowToastEvent'; 

export default class CaseStatusCommunication extends LightningElement {

    get caseStatuses() {
        return [
             { label: 'New', value: 'New' },
             { label: 'Working', value: 'Working' },
             { label: 'Escalated', value: 'Escalated' },
             { label: 'Closed', value: 'Closed' },

        ];
    }

    
    selectedCaseStatus
    caseList
    showSpinnerFlag=false;

    handleCaseStatusChange(event){
        this.showSpinnerFlag=true;
        this.selectedCaseStatus = event.detail.value;
        console.log(this.selectedCaseStatus);

        getCaseStatus({ caseStatus : this.selectedCaseStatus})
        .then((result) => {
          this.caseList = result;
          this.error = undefined;
          console.log(JSON.stringify(result));
          this.showSuccessToast('Your Case Status is Successfully Searched');
         this.showSpinnerFlag=false;
    
      })
      .catch((error) => {
          this.error = error;
          this.result = undefined;
          console.log(error);
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