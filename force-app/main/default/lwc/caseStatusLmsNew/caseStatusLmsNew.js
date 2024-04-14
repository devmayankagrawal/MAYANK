import { LightningElement, wire } from 'lwc';
import MYCHANNEL from "@salesforce/messageChannel/CaseDataChannel__c";
import {publish, MessageContext} from "lightning/messageService"


export default class CaseStatusLmsNew extends LightningElement {

    @wire(MessageContext)
    context

    caseStatusName
    caseList
    showSpinnerFlag = false
    totalCases

    get options() {
        return [
            { label: 'New', value: 'New' },
            { label: 'Working', value: 'Working' },
            { label: 'Escalated', value: 'Escalated' },
            { label: 'Closed', value: 'Closed' }
        ];
    }

    handleCaseStatusChange(event) {  
        this.caseStatusName = event.detail.value;
        
            const message={
                caseStatus:{
                    value:this.caseStatusName
                }
    
             }
        
            publish(this.context, MYCHANNEL, message);
    }
}