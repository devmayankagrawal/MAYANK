import { api, LightningElement } from 'lwc';

export default class SliderComponent extends LightningElement {

    val

    @api sliderResetChildMethod(){
        this.val=0
    }


}