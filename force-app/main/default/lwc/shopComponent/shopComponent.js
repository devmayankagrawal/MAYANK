import { LightningElement } from 'lwc';

export default class ShopComponent extends LightningElement {



    closeButtonHandler(){
        const myShopEvent = new CustomEvent('myshopevent',{detail : false});
        this.dispatchEvent(myShopEvent);
    }
}