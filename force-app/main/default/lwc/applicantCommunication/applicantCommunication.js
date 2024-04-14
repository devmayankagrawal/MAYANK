import { LightningElement, track } from 'lwc';
import searchApplicantAddresses from '@salesforce/apex/CentralApplicantClass.searchApplicantAddresses';
import { ShowToastEvent } from 'lightning/platformShowToastEvent'; 

export default class ApplicantCommunication extends LightningElement {

   @track objApplicant = {'sobjectType' : 'Applicant__c'}
    adressList
    

    applicantRecordHandler(){
        
        this.objApplicant.Name = this.template.querySelector('lightning-input[data-formfield="applicantId"]').value;
        console.log(this.objApplicant.Name);

        searchApplicantAddresses({ objApp : this.objApplicant})
    .then((result) => {
      this.adressList = result;
      this.error = undefined;
      console.log(JSON.stringify(result));
      this.showSuccessToast('Applicant Address Records Searched Succesfuuly');
       

  })
  .catch((error) => {
      this.error = error;
      this.result = undefined;
      console.log(this.error);
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