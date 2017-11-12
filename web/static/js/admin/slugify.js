/*
 * Used for automatic slug generation on forms
 */
(function($){
	//converts string into string that can be used for slug
	//RULES: limited to 80 characters long, only lowercase letters,
	//numbers and hypens allowed, hyphens cannot repeat and must not
	//start or end with hyphen
	function slugify(text){
		if(!text){
			return '';
		}
		var slugMaxChar = 80;
		return text.toLowerCase().replace(/[\s-_]+/g, '-').replace(/&+/g, 'and').replace(/^[-]+|[-]$|[^a-z0-9-]/g, '').slice(0, slugMaxChar);
	}

	$('[data-slug-source]').on('blur', function(event){
		var slugSource = this.value;
		var slugDest = document.querySelector('[data-slug]');
    	//only replace destination text with generated slug if it doesn't have a value
    	if(slugDest.value){
    		return;
    	}
    	slugDest.value = slugify(slugSource);
	});
})(aQuery);