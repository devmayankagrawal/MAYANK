import { api, LightningElement } from 'lwc';

export default class SliderCompo extends LightningElement {
    val
    @api sliderCompoMethod(){
        this.val=0
    }
}