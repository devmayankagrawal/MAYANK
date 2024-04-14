public class ScheduleBatchAccountRatingCold implements Schedulable{

    public void execute(SchedulableContext SC){
        Database.executeBatch(new BatchAccountRatingCold());
    }
}