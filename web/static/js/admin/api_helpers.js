
export function fetchJson(url){
    return fetch(url).then((data) => {return data.json();}).then((json) => {return json.data;});
}