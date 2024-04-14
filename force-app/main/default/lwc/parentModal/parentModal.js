import { LightningElement } from 'lwc';
import newSearchAddresses from '@salesforce/apex/ApplicantProvider.newSearchAddresses';
export default class ParentModal extends LightningElement {

    showPopupModalFlag = false
    showaddressbuttonFlag=false
    addressList
    objApplicant = {'sobjectType' : 'Applicant__c'}

    showPopupHandler(){
        this.objApplicant.Name = this.template.querySelector('lightning-input[data-formfield="applicantId"]').value;
        console.log(this.objApplicant.Name);
        this.showPopupModalFlag = true

        newSearchAddresses({objApp : this.objApplicant })
        .then((result)=>{
            this.result=result;
            this.addressList=result;
            this.error=undefined
            console.log(JSON.stringify(this.addressList));
            this.showaddressbuttonFlag=false;

        })
        .catch((error)=>{
            this.error=error;
            this.result=undefined
            console.log(this.error);

        });        

    }
    closePopupHandler(event){
        this.showPopupModalFlag = false 
       // this.showPopupModalFlag = event.detail; //

    }
    
    
}