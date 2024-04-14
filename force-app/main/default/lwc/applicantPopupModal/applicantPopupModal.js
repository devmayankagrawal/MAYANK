import { LightningElement } from 'lwc';
import searchApplicantAddresses from '@salesforce/apex/CentralApplicantClass.searchApplicantAddresses';

export default class ApplicantPopupModal extends LightningElement {

    showPopupModalFlag=false
    adressList

    objApplicant = {'sobjectType' : 'Applicant__c'}

    applicantRecordHandler(){
        this.showPopupModalFlag=true;

        this.objApplicant.Name = this.template.querySelector('lightning-input[data-formfield="applicantId"]').value;
        console.log(this.objApplicant.Name);

        searchApplicantAddresses({ objApp : this.objApplicant})
    .then((result) => {
      this.adressList = result;
      this.error = undefined;
      console.log(JSON.stringify(result));
      
       

  })
  .catch((error) => {
      this.error = error;
      this.result = undefined;
      console.log(this.error);
  });

    }

    closePopupModalHandler(event){
        this.showPopupModalFlag=false; //easy way
        this.objApplicant = event.detail;
    }
}