import { LightningElement } from 'lwc';
import getAllAccountsType from '@salesforce/apex/CentralAccountClass.getAllAccountsType';

export default class AccountLoop extends LightningElement {

    selectedAccountType
    acclist

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
        this.selectedAccountType = event.detail.value;
        console.log(this.selectedAccountType)

        getAllAccountsType({ accType : this.selectedAccountType})
    .then((result) => {
      this.acclist = result;
      this.result = result;
      this.error = undefined;
      console.log(result);
      

  })
  .catch((error) => {
      this.error = error;
      this.result = undefined;
  });
    }
}