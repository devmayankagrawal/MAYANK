import { LightningElement } from 'lwc';
import createAddressRecord from "@salesforce/apex/AddressProvider.createAddressRecord"
export default class AddressCompo extends LightningElement {

    addrObj = {'sobjectType' : 'Address__c'}
    createNewAddressHandler(){
        this.addrObj.Country__c = this.template.querySelector('lightning-input[data-formfield="country"]').value;
       
        this.addrObj.Applicant__c = this.template.querySelector('lightning-input[data-formfield="applicant"]').value;
        this.addrObj.Address_Line_2__c = this.template.querySelector('lightning-input[data-formfield="addressLine2"]').value;
        this.addrObj.Country__c = this.template.querySelector('lightning-input[data-formfield="country"]').value;
       
        createAddressRecord({ objAddr : this.addrObj})
        .then((result) => {
          this.result = result;
          this.error = undefined;
      })
      .catch((error) => {
          this.error = error;
          this.result = undefined;
      });

    }

}