import { LightningElement } from 'lwc';
import getAllAccountType from '@salesforce/apex/AccountCentralClass.getAllAccountType';
export default class LoopAccountStatement extends LightningElement {


    selectedAccType
    accList

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
        this.selectedAccType = event.detail.value;

        getAllAccountType({accType : this.selectedAccType})
        .then((result) => {
          this.accList = result;
          this.error = undefined;
          
      })
      .catch((error) => {
          this.error = error;
          this.result = undefined;
      });
    }

}