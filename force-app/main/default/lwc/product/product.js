import { LightningElement, track } from 'lwc';
import newSearchAddresses from '@salesforce/apex/ApplicantProvider.newSearchAddresses'

export default class Product extends LightningElement {

     @track objApplicant = {'sobjectType' : 'Applicant__c'}
    addressList

    applicantRecordHandler(){
         this.objApplicant.Name = this.template.querySelector('lightning-input[data-formfield="applicantId"]').value;
         
         newSearchAddresses({objApp : this.objApplicant})
         .then((result) => {
             
             this.result = result;
             this.error = undefined;
             console.log(JSON.stringify(result));
             this.addressList = result;
         })
         .catch((error) => {
             this.error = error;
             this.result = undefined;
             console.log(this.error);
         });
    
    }
}