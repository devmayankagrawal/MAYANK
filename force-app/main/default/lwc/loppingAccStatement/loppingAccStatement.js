import { LightningElement } from 'lwc';
import getAllAccountsType from '@salesforce/apex/CentralAccountClass.getAllAccountsType';
import { ShowToastEvent } from 'lightning/platformShowToastEvent'; 

export default class LoppingAccStatement extends LightningElement {

    selectedAccType
    accList
    showTableFlag = false
    totalRecords
    showSpinnerFlag=false

    get optionsType() {
        return [
            { label: 'Prospect', value: 'Prospect' },
            { label: 'Customer - Direct', value: 'Customer - Direct' },
            { label: 'Customer - Channel', value: 'Customer - Channel' },
            { label: 'Channel Partner / Reseller', value: 'Channel Partner / Reseller' },
            { label: 'Installation Partner', value: 'Installation Partner' },
            { label: 'Technology Partner', value: 'Technology Partner' },
            { label: 'Other', value: 'Other' },
        ];
    }

    handleChangeType(event) {
        debugger
        this.showSpinnerFlag=true;
        this.selectedAccType = event.detail.value;
        console.log(event.detail.value);

        getAllAccountsType({ accType : this.selectedAccType})
    .then((result) => {
      this.accList = result;
       this.error = undefined;
      console.log(this.accList);
      this.showSuccessToast('Your Account Type is Searched');

      this.showSpinnerFlag=false;

      this.totalRecords = result.length;

      if(result.length > 0){
          this.showTableFlag=true
      }
      else{
        this.showTableFlag=false
      }

  })
  .catch((error) => {
      this.error = error;
      this.result = undefined;

      this.showTableFlag=false
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