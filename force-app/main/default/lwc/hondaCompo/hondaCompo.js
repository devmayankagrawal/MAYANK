import { LightningElement } from 'lwc';
import searchApplicantAddresses from '@salesforce/apex/CentralApplicantClass.searchApplicantAddresses';

export default class HondaCompo extends LightningElement {

    objApplicant = {'sobjectType' : 'Applicant__c'}
    addressList
    showPopupModalFlag=false

    applicantRecordHandler(){
       this.objApplicant.Name = this.template.querySelector('lightning-input[data-formfield="applicantId"]').value;
       this.showPopupModalFlag=true

       searchApplicantAddresses({ objApp : this.objApplicant})
    .then((result) => {
      this.addressList = result;
      this.error = undefined;
      console.log(JSON.stringify(result))
     

  })
  .catch((error) => {
      this.error = error;
      this.result = undefined;
      console.log(error)
  });

    }
    closePopUphandler(event){
      this.showPopupModalFlag=false 
       
    }
}