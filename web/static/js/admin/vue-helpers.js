export function extractProps(container, keys){
    const props = {};

    keys.forEach(key => {
        props[key] = container.dataset[key];
    });

    return props;
}