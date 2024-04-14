import { LightningElement } from 'lwc';

export default class Day6Compo extends LightningElement {

    showMessage = false

    showNameHandler(event){

        this.showMessage = event.target.checked

    }
    
}