global class YoutubeRequestApi {
    
    webService static void getYoutubeVideoStatistics(String videoId, String recId){
        
        string key = 'AIzaSyCgqF_pADybGMWbk-k5POAGvCerCs8AYb0';
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://youtube.googleapis.com/youtube/v3/videos?part=Statistics&id='+videoId+'&key='+key);
        request.setMethod('GET');
        
        HttpResponse response = http.send(request);
        system.debug('Status Code ='+response.getStatusCode());
        
        Integration_Message__c objIntMessage = new Integration_Message__c();
        objIntMessage.YouTube_Channel__c = recId; //Parent ID
        objIntMessage.Request__c = request.toString();
        objIntMessage.Response__c = response.getBody();
        objIntMessage.Outbound_API__c = true;
        
        if(objIntMessage !=null ){
            insert objIntMessage;
        }
        
        
        
        if(response.getStatusCode()== 200){
            JsonParserWrapper objJsonPar = (JsonParserWrapper) JSON.deserialize(response.getBody(), JsonParserWrapper.class);
            
            YouTube_Channel__c objYouTubeChann = new YouTube_Channel__c();
            objYouTubeChann.Id = recId;
            objYouTubeChann.View_Counts__c = Integer.valueOf(objJsonPar.items[0].statistics.viewCount);
            objYouTubeChann.Comments_Count__c = Integer.valueOf(objJsonPar.items[0].statistics.commentCount);
            
            Database.update(objYouTubeChann,false);
            
        }
    }
    public class JsonParserWrapper{
        
        public String etag{get;set;}
        public list<items> items{get;set;}
        public String kind{get;set;}
    }
    public class statistics{
        public String viewCount{get;set;}
        public String likeCount{get;set;}
        public String dislikeCount{get;set;}
        public String favoriteCount{get;set;}
        public String commentCount{get;set;}
    }
    public class items{
        public String id{get;set;}
        public String etag{get;set;}
        public statistics statistics{get;set;}
        public String kind{get;set;}
    }
    
}