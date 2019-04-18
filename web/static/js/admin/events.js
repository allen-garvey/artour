export function addListener(selector, eventName, callback){
    document.querySelectorAll(selector).forEach((element)=>{
        element.addListener(eventName, (e)=>{
            callback(e, element);
        }, false);
    });
}