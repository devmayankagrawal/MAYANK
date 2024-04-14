const store={};

const subscribe = (sendDataEvent,callback) =>{
        if(!store[sendDataEvent]){
        store[sendDataEvent] = new Set();
        }
        store[sendDataEvent].add(callback);
};
const unsubscribe = (sendDataEvent,callback) =>{
        if(store[sendDataEvent]){
        store[sendDataEvent].delete(callback);
        }
};
const publish = (sendDataEvent, payLoad) =>{
        if(store[sendDataEvent]){
        store[sendDataEvent].forEach(callback=> {
            try{
            callback(payLoad);
            }
            catch(error){
            console.log(error);
            }
});
}
};
export default{
        subscribe,
        unsubscribe,
        publish
}