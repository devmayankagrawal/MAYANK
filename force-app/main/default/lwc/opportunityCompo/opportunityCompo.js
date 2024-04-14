import { LightningElement } from 'lwc';
import createOpportunityRecord from "@salesforce/apex/OpportunityProvider.createOpportunityRecord"

export default class OpportunityCompo extends LightningElement {
    objOpportunity = {'sobjectType' : 'Opportunity'}

    saveButton(){
        this.objOpportunity.Name = this.template.querySelector('lightning-input[data-formfield="opportunityName"]').value;
        this.objOpportunity.Type = this.template.querySelector('lightning-input[data-formfield="opportunityType"]').value;
        this.objOpportunity.StageName = this.template.querySelector('lightning-input[data-formfield="opportunityStage"]').value;
        this.objOpportunity.Amount = this.template.querySelector('lightning-input[data-formfield="opportunityAmount"]').value;
        this.objOpportunity.CloseDate = this.template.querySelector('lightning-input[data-formfield="opportunityCloseDate"]').value;

        
        createOpportunityRecord({ objOpp : this.objOpportunity})
        .then((result) => {
          this.result = result;
          this.error = undefined;
      })
      .catch((error) => {
          this.error = error;
          this.result = undefined;
      });

    }


}