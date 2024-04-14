import { LightningElement } from 'lwc';
import getAllAccountsGender from '@salesforce/apex/CentralApplicantClass.getAllAccountsGender';

export default class LoopingApplicantStatement extends LightningElement {

    totalRecords
    showTableFlag = false
    selectedApplicantGender
    appList

    

    get optionsGender() {
        return [
            { label: 'Male', value: 'Male' },
            { label: 'Female', value: 'Female' },
            { label: 'Transgender', value: 'Transgender' },
        ];
    }

    handleChangeGender(event) {
        this.selectedApplicantGender = event.detail.value;
        console.log(event.detail.value);

        getAllAccountsGender({ appGender : this.selectedApplicantGender})
        .then((result) => {
          this.appList = result;
           this.error = undefined;
          console.log(this.objApplicant);
          
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



    }