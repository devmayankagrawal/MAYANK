import { LightningElement } from 'lwc';

export default class HelloBear extends LightningElement {

    firstName
    lastName
    dob
    gender

    showName(){

        var inputFields=this.template.querySelectorAll("lightning-input");

        inputFields.forEach(element=>{
            if(element.name=='firstName'){
              this.firstName = element.value;
            }
      
            if(element.name=='lastName'){
              this.lastName = element.value;
            }
            
            if(element.name=='gender'){
                this.gender = element.value;
              }

            
            if(element.name=='dob'){
                this.dob = element.value;
              }
        });
      
    }

    get options() {
        return [
            { label: 'Male', value: 'Male' },
            { label: 'Female', value: 'Female' },
            { label: 'Transgender', value: 'Transgender' },
        ];
    }

    handleChange(event) {
        this.gender = event.detail.value;
    }


}