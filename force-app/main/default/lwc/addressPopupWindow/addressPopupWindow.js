import { api, LightningElement, track } from 'lwc';

const  columns = [
    { label: 'Address ID', fieldName: 'Name', editable: true },
    { label: 'Country', fieldName: 'Country__c', editable: true },
    { label: 'State', fieldName: 'State__c', editable: true },
    { label: 'City', fieldName: 'City__c', editable: true }
  ];


export default class AddressPopupWindow extends LightningElement {

     @api receivedAdressList
     draftValues=[];
     columns = columns;

   @track objApplicant = {'sobjectType' : 'Applicant__c'}

    closePopupWindow(){
        const shopEvent = new CustomEvent('myshopevent',{detail : this.objApplicant});
        this.dispatchEvent(shopEvent);
    }

    selectedRecordsHandler(){
        
    }
}