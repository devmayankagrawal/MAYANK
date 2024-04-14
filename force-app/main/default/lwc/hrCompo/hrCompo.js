import { api, LightningElement } from 'lwc';

export default class HrCompo extends LightningElement {

hrSalary = 4000

@api   hrMethod(){
            this.hrSalary=700
     }
}