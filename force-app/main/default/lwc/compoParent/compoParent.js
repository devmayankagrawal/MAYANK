import { LightningElement } from 'lwc';
import newSearchAddresses from '@salesforce/apex/ApplicantProvider.newSearchAddresses';
export default class CompoParent extends LightningElement {


    objApplicant = {'sobjectType' : 'Applicant__c'}
    adressList
    showPopupModalFlag=false

    applicantRecordHandler(){
        this.objApplicant.Name = this.template.querySelector('lightning-input[data-formfield="applicantId"]').value;
        this.showPopupModalFlag=true

        newSearchAddresses({ objApp : this.objApplicant})
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
    closePopupHandler(){
        this.showPopupModalFlag=false
    }
}