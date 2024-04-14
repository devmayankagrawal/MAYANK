trigger AccountRecursiveTrigger on Account (before insert) {
    
    public static Boolean flag = false;
    
    
    public static void callMethod(){
        
        if(!flag){
            flag = true;
            Account objAcc = new Account(Name='Jindal Works');
            insert objAcc;
        }
    }
}