import { LightningElement } from 'lwc';

export default class Day3Component extends LightningElement {

firstName = "My name is Lakhan"

myMethod1(){
    console.log(this.myMethod2)
}
get myMethod2(){
    return "Silver Microsystems"
}
getFirstName(){
    console.log(this.firstName)
}
}