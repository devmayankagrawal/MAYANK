import { LightningElement } from 'lwc';

export default class Day4Component extends LightningElement {

    firstName
    lastName
    gender
    dob

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
   
}