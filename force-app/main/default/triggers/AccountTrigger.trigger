trigger AccountTrigger on Account (before insert, before update) {
    
    for(Account objAcc : trigger.new){
        
        if(objAcc.Type == 'Prospect'){
            objAcc.Rating = 'Hot';
        }
        else{
            objAcc.Rating = '';
        }
    }

}