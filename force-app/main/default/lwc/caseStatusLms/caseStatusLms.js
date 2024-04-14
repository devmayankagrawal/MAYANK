import { LightningElement, wire } from 'lwc';
import MYCHANNEL from "@salesforce/messageChannel/CaseStatusChannel__c";
import {publish, MessageContext} from "lightning/messageService"
import getAllCaseStatus from '@salesforce/apex/CaseProvider.getAllCaseStatus';


export default class CaseStatusLms extends LightningElement {

    @wire(MessageContext)
    context
   selectedCaseStatus
   caseList

   value = 'New';

   get options() {
    return [
        { label: 'New', value: 'New' },
        { label: 'Working', value: 'Working' },
        { label: 'Escalated', value: 'Escalated' },
        { label: 'Closed', value: 'Closed' },
    ];
}

    selectCaseStatusHandler(event){
        debugger;
            this.selectedCaseStatus = event.detail.value;
            console.log( this.selectedCaseStatus)

            
            const message={
                caseStatus:{
                    value:this.caseList
                }
    
             }
        
             publish(this.context, MYCHANNEL, message);
            
            getAllCaseStatus({caseStatus : this.selectedCaseStatus  })
            .then((result) => {
    
                console.log(result)
                this.caseList = result
                this.result = result;
                this.error = undefined;
               
        
            })
            .catch((error) => {
                console.log(error)
                this.error = error;
                this.result = undefined;
                console.log("Message = "+this.error);
            
            });
        
            


    
    
    }
}