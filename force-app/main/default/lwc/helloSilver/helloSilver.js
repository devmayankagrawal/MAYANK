import { LightningElement } from 'lwc';

export default class HelloSilver extends LightningElement {
   firstName
   lastName
   gender
   dob
   get options() {
    return [
        { label: 'Male', value: 'Male' },
        { label: 'Female', value: 'Female' },
        { label: 'Transgender', value: 'Transgender' },
    ];
}

    showName(){
    
        var inputFields=this.template.querySelectorAll("lightning-input");
  inputFields.forEach(element=>{
      if(element.name=='firstName'){
        this.firstName = element.value;
      }

      if(element.name=='lastName'){
        this.lastName = element.value;
      }
      
      if(element.name=='dob'){
        this.dob = element.value;
      }
  });

    
    }
    handleChange(event) {
        this.gender = event.detail.value;
    }
   
}