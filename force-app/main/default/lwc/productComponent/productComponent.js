import { LightningElement } from 'lwc';

export default class ProductComponent extends LightningElement {

    receivedFromTax

    taxHandler(event){
        console.log('Calling received from tax child');
        this.receivedFromTax = event.detail;
    }




}