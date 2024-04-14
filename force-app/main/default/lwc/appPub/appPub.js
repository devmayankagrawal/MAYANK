import { LightningElement } from 'lwc';
import pubsubappadr from 'c/pubsubappadr';
import searchApplicantAddresses from '@salesforce/apex/CentralApplicantClass.searchApplicantAddresses';

export default class AppPub extends LightningElement {

    objApplicant = {'sobjectType' : 'Applicant__c'}
    addressList

    sendDataHandler(){
        this.objApplicant.Name =this.template.querySelector('lightning-input[data-formfield="applicantId"]').value;
        pubsubappadr.publish("sendDataEvent", this.addressList);
 
        searchApplicantAddresses ({objApp :this.objApplicant})
    .then ( (result)=>{
     console.log(JSON.stringify(result))
     this.error = undefined
     this.addressList = result;
     })
    .catch( (error) =>{
     this.error = error;
     this.result = undefined
     console.log(this.error);
 })
    }
}