public class Insurance {

    public string prefixName(String Name, String Gender){
        string finalName;
        if(Gender=='Male'){
            finalName = 'Mr.'+Name;
        }
        else{
            if(Gender=='Female'){
                finalName='Ms.'+Name;
            }
        }
        return finalName;
    }
    
}