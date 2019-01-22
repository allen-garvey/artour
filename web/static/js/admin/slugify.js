/*
 * Used for automatic slug generation on forms
 */

import { aQuery as $ } from './aquery.js';

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

function autofillSlug(target, slug, shouldForce=false){
	if(target.value && !shouldForce){
		return;
	}
	target.value = slug;
}




export function initializeAutofillSlug(){
	$('[data-slug-source]').on('blur', function(event){
		const slugSource = this.value;
		const slugDest = document.querySelector('[data-slug]');

    	autofillSlug(slugDest, slugify(slugSource));
	});

	//initialize regenerate button
	$('#autofill-image-button').on('click', function(event){
		//use query selector, because there is a bug in this version of aQuery in getting value
		const slugSource = document.querySelector('[data-slug-source]');
		const slugDest = document.querySelector('[data-slug]');
		if(!slugSource || !slugDest){
			return;
		}
		autofillSlug(slugDest, slugify(slugSource.value), true);
	});
}