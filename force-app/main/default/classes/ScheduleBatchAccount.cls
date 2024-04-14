public class ScheduleBatchAccount implements Schedulable {

    public void execute(SchedulableContext SC){
        Database.executeBatch(new BatchAccountCount());
    }
}