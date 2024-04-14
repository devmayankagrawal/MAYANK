import { LightningElement } from 'lwc';

export default class ShopCompo extends LightningElement {

    sendDataToMallHandler(){
        const shopEvent = new CustomEvent("myshopevent", {detail : "tu tu taraaa"});
        this.dispatchEvent(shopEvent);
    }
}