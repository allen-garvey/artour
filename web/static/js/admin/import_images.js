export function extractImages(files){
    const imageFilesMap = new Map();

    //file list might not have map or forEach functions
    for(let file of files){
        if(file.type.match(/^image\//)){
            const name = file.name;
            const nameWithoutExtension = name.replace(/\.\w{3,4}$/, '');
            const extension = name.replace(nameWithoutExtension, '');
            const nameDashSplit = nameWithoutExtension.split('-');
            const sizeSuffix = nameDashSplit[nameDashSplit.length - 1];
            const uniqueName = nameDashSplit.slice(0, nameDashSplit.length-1).join('-');

            const fileObject = imageFilesMap.has(uniqueName) ? imageFilesMap.get(uniqueName) : {};
            fileObject[sizeSuffix] = name;
            fileObject.thumbnail = `${uniqueName}-thumb${extension}`;
            imageFilesMap.set(uniqueName, fileObject);
        }
    }
    return [...imageFilesMap.values()];
}