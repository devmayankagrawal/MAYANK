import { LightningElement } from 'lwc';

export default class Day8MayCompo extends LightningElement {

    
    showMessageFlag=false;
    showSpinnerFlag=false;

    searchButtonHandler(){
        this.showSpinnerFlag=true;
        this.showMessageFlag=true;
        this.showSpinnerFlag=false;

    }

    editButtonHandler(){
        this.showSpinnerFlag=true;
        this.showMessageFlag=false;
        this.showSpinnerFlag=false;
    }




}