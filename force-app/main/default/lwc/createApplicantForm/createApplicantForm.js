import { LightningElement } from 'lwc';
import createApplicantRecord from '@salesforce/apex/CentralApplicantClass.createApplicantRecord';


export default class CreateApplicantForm extends LightningElement {

    objApplicant = {'sobjectType' : 'Applicant__c'}

    saveApplicantRecord(){       
        this.objApplicant.First_Name__c = this.template.querySelector('lightning-input[data-formfield="applicantFirstName"] ').value;
        this.objApplicant.Last_Name__c = this.template.querySelector('lightning-input[data-formfield="applicantLastName"] ').value;
        this.objApplicant.DOB__c = this.template.querySelector('lightning-input[data-formfield="applicantDob"] ').value;


        createApplicantRecord({ objApp : this.objApplicant})
        .then((result) => {
          this.result = result;
          this.error = undefined;
      })
      .catch((error) => {
          this.error = error;
          this.result = undefined;
      });
    
  }

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
  
}