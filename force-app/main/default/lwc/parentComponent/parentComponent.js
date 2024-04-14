import { LightningElement, track } from 'lwc';
import searchApplicantAddresses from '@salesforce/apex/CentralApplicantClass.searchApplicantAddresses';
import { ShowToastEvent } from 'lightning/platformShowToastEvent'; 

export default class ParentComponent extends LightningElement {

    applicantObject = {'sobjectType' : 'Applicant__c'}
    addressList
    showTableFlag=false
    showSpinnerFlag=false

    applicantRecordHandler(){
        this.applicantObject.Name = this.template.querySelector('lightning-input[data-formfield="applicantId"]').value;
        this.showSpinnerFlag=true

        searchApplicantAddresses({objApp : this.applicantObject })
      .then ( (result)=>{
          console.log(JSON.stringify(result))
          this.error = undefined
          this.addressList = result;
          this.showTableFlag=true
          this.showSpinnerFlag=false
          this.showSuccessToast('Your Applicant Adress is searched...!!!');
      })
      .catch( (error) =>{
          this.error = error;
          this.result = undefined
          console.log(this.error);
      })
      
    
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