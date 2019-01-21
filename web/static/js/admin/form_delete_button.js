/*
 * Used in edit form to delete items
 */

import { aQuery as $ } from './aquery.js';

export function initializeFormDeleteButton(){
	$("[data-button='delete']").on('click', function(event){
		event.preventDefault();
		const deleteForm = document.querySelector("[data-form='delete']");
		if(!deleteForm || !window.confirm("Are you sure you want to delete this item?")){
			return;
		}
		deleteForm.submit();
	});
 
}