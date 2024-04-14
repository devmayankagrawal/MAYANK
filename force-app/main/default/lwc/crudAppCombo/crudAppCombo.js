import { LightningElement } from 'lwc';
import createApplicantRecord from "@salesforce/apex/ApplicantProvider.createApplicantRecord"

export default class CrudAppCombo extends LightningElement {
    applicantObject = {'sobjectType' : 'Applicant__c'}
    result
    error

    createApplicantHandler(){
        this.applicantObject.First_Name__c = this.template.querySelector('lightning-input[data-formfield="applicantFirstName"]').value
        this.applicantObject.Last_Name__c = this.template.querySelector('lightning-input[data-formfield="applicantLastName"]').value
        this.applicantObject.Gender__c = this.template.querySelector('lightning-input[data-formfield="applicantGender"]').value
        this.applicantObject.DOB__c = this.template.querySelector('lightning-input[data-formfield="applicantDOB"]').value

        createApplicantRecord({objApplicant : this.applicantObject})
        .then((result) => {
            this.result = result;
            this.error = undefined;
            this.showSuccessToast();
        })
        .catch((error) => {
            this.error = error;
            this.result = undefined;
            console.log("Message = "+this.error);
        });
  
        
    }

    searchApplicantHandler(){
        console.log('search Js Method');
    }
    updateApplicantHandler(){
        console.log('Update Js Method');
    }
    deleteApplicantHandler(){
        console.log('Delete Js Method');
    }
    undeleteApplicantHandler(){
        console.log('Undelete Js Method');
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