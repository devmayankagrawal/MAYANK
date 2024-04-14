import { LightningElement } from 'lwc';
import createApplicantRecord from "@salesforce/apex/ApplicantProvider.createApplicantRecord"
export default class ApplicantCompo extends LightningElement {

    applicantObject = {'sobjectType' : 'Applicant__c'}

    createNewApplicantHandler(){
        this.applicantObject.First_Name__c = this.template.querySelector('lightning-input[data-formfield="applicantFirstName"]').value;
        this.applicantObject.Last_Name__c = this.template.querySelector('lightning-input[data-formfield="applicantLastName"]').value;
        this.applicantObject.DOB__c = this.template.querySelector('lightning-input[data-formfield="applicantDob"]').value;
        this.applicantObject.Email_ID__c = this.template.querySelector('lightning-input[data-formfield="applicantEmailId"]').value;

        createApplicantRecord({ objApplicant : this.applicantObject})
        .then((result) => {
          this.result = result;
          this.error = undefined;
      })
      .catch((error) => {
          this.error = error;
          this.result = undefined;
      });

    }
    get options() {
        return [
            { label: 'Male', value: 'Male' },
            { label: 'Female', value: 'Female' },
            { label: 'Transgender', value: 'Transgender' },
        ];
    }

    handleGender(event) {
        console.log(event.detail.value);
        this.applicantObject.Gender__c = event.detail.value;
    }

}