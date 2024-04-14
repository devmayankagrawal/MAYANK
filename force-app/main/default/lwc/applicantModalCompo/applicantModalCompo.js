import { LightningElement } from 'lwc';

export default class ApplicantModalCompo extends LightningElement {

    showAddressFlag = false
    applicantId
    objApplicant = {'sobjectType' : 'Applicant__c'}


    showaddressHandler(){
        this.showAddressFlag = true

        this.applicantId = this.template.querySelector('lightning-input[data-formfield="applicantID"]').value
        console.log(this.applicantId);
       
        newSearchAddresses({appName : this.applicantId})
        .then((result) => {
            
            this.result = result;
            this.error = undefined;
            console.log(this.result);
            this.addressList = result;
        })
        .catch((error) => {
            this.error = error;
            this.result = undefined;
            console.log(this.error);
        });

    }

    childAddressHandler(){
        this.showAddressFlag = false
         this.objApplicant = event.detail; 
    }
}