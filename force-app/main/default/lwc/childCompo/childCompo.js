import { api, LightningElement } from 'lwc';

export default class ChildCompo extends LightningElement {
   @api childData
   @api employeeNameFromParent
   @api carFromParent
   @api objAccReceivedParent
}