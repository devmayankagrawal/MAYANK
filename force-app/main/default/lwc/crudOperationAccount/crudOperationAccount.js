import { LightningElement } from 'lwc';

export default class CrudOperationAccount extends LightningElement {


    createAccountHandler(){
        console.log('create')
    }

    searchAccountHandler(){
        console.log('search')
    }

    updateAccountHandler(){
        console.log('update')
    }

    deleteAccountHandler(){
        console.log('delete')
    }

    undeleteAccountHandler(){
        console.log('undelete')
    }
}