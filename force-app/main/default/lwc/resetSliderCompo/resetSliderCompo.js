import { LightningElement } from 'lwc';

export default class ResetSliderCompo extends LightningElement {

    resetSliderMethod(){
        this.template.querySelector('c-slider-compo').sliderCompoMethod();
    }
}