import { LightningElement } from 'lwc';
import createApplicantRecords from '@salesforce/apex/ApplicantCentralClass.createApplicantRecords';

export default class ApplicantRecordCreateCompo extends LightningElement {

    objApplicant = {'sobjectType' : 'Applicant__c'}

    get optionsGender() {
        return [
            { label: 'Male', value: 'Male' },
            { label: 'Female', value: 'Female' },
            { label: 'Transgender', value: 'Transgender' },
        ];
    }

    handleChangeGender(event) {
        this.objApplicant.Gender__c = event.detail.value;
    }
    applicantRecordHandler(){
      this.objApplicant.First_Name__c = this.template.querySelector('lightning-input[data-formfield="appFirstName"]').value;
      this.objApplicant.Last_Name__c = this.template.querySelector('lightning-input[data-formfield="appLastName"]').value;
      this.objApplicant.DOB__c = this.template.querySelector('lightning-input[data-formfield="appDOB"]').value;
      this.objApplicant.Mobile_Number__c= this.template.querySelector('lightning-input[ data-formfield="appNumber"]').value;
      this.objApplicant.Email_ID__c= this.template.querySelector('lightning-input[ data-formfield="appEmail"]').value;
console.log('#Record Created = ' +this.objApplicant.First_Name__c);
      
      createApplicantRecords({ objApp : this.objApplicant})
      .then((result) => {
        this.result = result;
        this.error = undefined;
    })
    .catch((error) => {
        this.error = error;
        this.result = undefined;
    });

    }


                    

}