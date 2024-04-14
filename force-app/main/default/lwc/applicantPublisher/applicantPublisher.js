import { LightningElement, track } from 'lwc';
import appAddrPubsub from 'c/appAddrPubsub';
import newSearchAddresses from '@salesforce/apex/ApplicantProvider.newSearchAddresses';

export default class ApplicantPublisher extends LightningElement {

    applicantName
    addressList
   @track objApplicant = {'sobjectType' : 'Applicant__c'}



   applicantRecordHandler(){
        this.objApplicant.Name = this.template.querySelector('lightning-input[data-formfield="applicantId"]').value;

       appAddrPubsub.publish("sendDataEvent" , this.addressList);

       newSearchAddresses({objApp : this.objApplicant})
       .then((result) => {
           
           this.result = result;
           this.error = undefined;
           console.log(this.addressList);
           this.addressList = result;
       })
       .catch((error) => {
           this.error = error;
           this.result = undefined;
           console.log(this.error);
       });
    }

            
}