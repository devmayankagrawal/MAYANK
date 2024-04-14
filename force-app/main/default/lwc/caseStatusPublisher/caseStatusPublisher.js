import { LightningElement } from 'lwc';
import caseStatusPubsub from 'c/caseStatusPubsub';
import getAllCaseStatus from '@salesforce/apex/CaseProvider.getAllCaseStatus';

export default class CaseStatusPublisher extends LightningElement {

    selectedCaseStatus
    caseList

    
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

        caseStatusPubsub.publish("sendDataEvent", this.caseList);
 
        
        getAllCaseStatus({caseStatus : this.selectedCaseStatus})
        .then((result) => {

            
            this.result = result;
            this.error = undefined;
            console.log(JSON.stringify(result));
            this.caseList = result;
            
         
        })
        .catch((error) => {
            this.error = error;
            this.result = undefined;
            console.log(this.error);
        });
   
         
    }
}