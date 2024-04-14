import { LightningElement } from 'lwc';
import getAllAccountsType from '@salesforce/apex/AccountProvider.getAllAccountsType'

export default class AccountLoopCompo extends LightningElement {

    selectedAccountType
    accList
    showTableFlag = false
    totalRecords

    get accTypes() {
        return [
            { label: 'Prospect', value: 'Prospect' },
            { label: 'In Customer - Direct', value: 'Customer - Direct' },
            { label: 'Customer - Channel', value: 'Customer - Channel' },
            { label: 'Channel Partner / Reseller', value: 'Channel Partner / Reseller' },
            { label: 'Installation Partner', value: 'Installation Partner' },
            { label: 'Technology Partner', value: 'Technology Partner' },
            { label: 'Other', value: 'Other' },
     
      
        ];
    }

    handleAccountTypeChange(event) {
        debugger

        this.selectedAccountType = event.detail.value;
        console.log(event.detail.value);

        getAllAccountsType({ accType : this.selectedAccountType})
        .then((result) => {
            
            console.log(result);
          this.accList = result;
          this.result = result;
          this.error = undefined;
          this.totalRecords = result.length

          if(result.length > 0){
            this.showTableFlag = true;
            
        }
        else{
            this.showTableFlag = false;
        }
        
        
      })
      .catch((error) => {
          console.log(error)
          this.error = error;
          this.result = undefined;
          this.showTableFlag = false;
      });
  
    }
}