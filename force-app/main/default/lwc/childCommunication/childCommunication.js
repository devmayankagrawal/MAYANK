import { api, LightningElement } from 'lwc';

export default class ChildCommunication extends LightningElement {

   @api receivedSalaryFromParent
   @api receivedEmployeeName
   @api carFromParent
   @api objAccountReceived
}