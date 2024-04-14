import { LightningElement } from 'lwc';

export default class LwcCompo21 extends LightningElement {

    firstName
    lastName
    dob
    gender

    get optionsGender() {
        return [
            { label: 'Male', value: 'Male' },
            { label: 'Female', value: 'Female' },
            { label: 'Transgender', value: 'Transgender' },
        ];
    }

    handleChangeGender(event) {
        this.gender = event.detail.value;
    }

    showName(){
        var inputFields=this.template.querySelectorAll("lightning-input");
        inputFields.forEach(element=>{
            if(element.name=='firstName'){
              this.firstName =    element.value;
            }
      
            if(element.name=='lastName'){
              this.lastName =    element.value;
            }
            if(element.name=='dob'){
                this.dob =    element.value;
              }
        });
        }

}