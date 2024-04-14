import { LightningElement } from 'lwc';

export default class HelloDiamond extends LightningElement {

name
firstName = 'Bunty'
lastName = 'Modi'
gender = 'Male'
phoneNumber = 985062542
salary = 850000.58
showFlag = true
currentDate = new Date()

Account = {
Name : "Bank of Baroda",
Type : "Prospect",
Rating : "Hot",
SLA__c : "Gold"
}

Applicant__c = {
    First_Name__c : 'Shanu',
    Last_Name__c : 'Agrawal',
    Gender__c : 'Male',


}
empList = ['Ram', 'Sita', 'Laxman']

}