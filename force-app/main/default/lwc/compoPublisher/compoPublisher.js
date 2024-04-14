import { LightningElement } from 'lwc';
import compopubsubfile from 'c/compopubsubfile';

export default class CompoPublisher extends LightningElement {

    accName

    accountHandler(){

      this.accName =  this.template.querySelector('lightning-input[data-formfield="accountName"]').value;

      compopubsubfile.publish("sendDataEvent", this.accName);
    }
}