import { LightningElement } from 'lwc';
export default class JsLearningCompo extends LightningElement {

    handleButton(){
        console.log(document.getElementById('demo').innerHTML = 'Hello JavaScript!');
       
    }
}