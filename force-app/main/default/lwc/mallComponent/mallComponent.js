import { LightningElement } from 'lwc';

export default class MallComponent extends LightningElement {

    showPopupModalFlag=false


    showPopoupHandler(){
        this.showPopupModalFlag=true;

    }

    closePopupHanndler(event){
        this.showPopupModalFlag=false; //easy way
        this.showPopupModalFlag = event.detail;
    }
}