import { LightningElement } from 'lwc';

export default class DisableButtonCompo extends LightningElement {
    
    showMessageFlag=false
    showSpinnerFlag = false
    searchHandler(){
        this.showSpinnerFlag=true;
        this.showMessageFlag=true;
        this.showSpinnerFlag=false;

    }
    editHandler(){
        this.showSpinnerFlag=true;
        this.showMessageFlag=false;
        this.showSpinnerFlag=false;
    }
}