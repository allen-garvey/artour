/*
 * Used for automatic slug generation on forms
 */

import { aQuery as $ } from './aquery.js';

export function initializeAutofillSlug(){
	//converts string into string that can be used for slug
	//RULES: limited to 80 characters long, only lowercase letters,
	//numbers and hypens allowed, hyphens cannot repeat and must not
	//start or end with hyphen
	function slugify(text){
		if(!text){
			return '';
		}
		const slugMaxChar = 80;
		return text.toLowerCase().replace(/[\s-_]+/g, '-').replace(/@+/g, 'at').replace(/&+/g, 'and').replace(/^[-]+|[-]$|[^a-z0-9-]/g, '').slice(0, slugMaxChar);
	}

	$('[data-slug-source]').on('blur', function(event){
		const slugSource = this.value;
		const slugDest = document.querySelector('[data-slug]');
    	//only replace destination text with generated slug if it doesn't have a value
    	if(slugDest.value){
    		return;
    	}
    	slugDest.value = slugify(slugSource);
	});
}