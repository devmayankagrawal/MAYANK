import { LightningElement } from 'lwc';

export default class MallCompo extends LightningElement {

    recievedFromShop = "Waiting From Child"

    mallHandler(event){
        console.log('Calling Received From Shop Child');
      this.recievedFromShop =  event.detail;
    }
}