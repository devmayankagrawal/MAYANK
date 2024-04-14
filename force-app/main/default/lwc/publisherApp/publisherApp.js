import { LightningElement, track } from 'lwc';
import pubsubappaddr from 'c/pubsubappaddr';
import searchApplicantAddresses from '@salesforce/apex/CentralApplicantClass.searchApplicantAddresses';

export default class PublisherApp extends LightningElement {

   @track objApplicant = {'sobjectType' : 'Applicant__c'}
   adressList
   
    applicantIdHandler(){
     this.objApplicant.Name =  this.template.querySelector('lightning-input[data-formfield="applicantId"]').value;
     pubsubappaddr.publish("sendDataEvent",this.adressList);

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
}