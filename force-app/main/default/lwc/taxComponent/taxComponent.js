import { api, LightningElement } from 'lwc';

export default class TaxComponent extends LightningElement {

   
    sendDataToProductHandler(){

        const shopEvent = new CustomEvent('myshopevent', {detail : 'Tu tuu tara'});
        this.dispatchEvent(shopEvent);
    }






}