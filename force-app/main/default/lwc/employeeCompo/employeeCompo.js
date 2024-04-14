import { LightningElement } from 'lwc';

export default class EmployeeCompo extends LightningElement {

    employeeHandler(){
        this.template.querySelector('c-hr-compo').hrMethod();
    }
}