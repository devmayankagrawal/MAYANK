import { LightningElement } from 'lwc';

export default class ResetSliderComponent extends LightningElement {



    resetSliderHandler(){
        this.template.querySelector('c-slider-component').sliderResetChildMethod();
    }









}