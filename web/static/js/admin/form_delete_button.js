/*
 * Used in edit form to delete items
 */
(function($){
	$("[data-button='delete']").on('click', function(event){
		event.preventDefault();
		var deleteForm = document.querySelector("[data-form='delete']");
		if(!deleteForm || !window.confirm("Are you sure you want to delete this item?")){
			return;
		}
		deleteForm.submit();
	});
 
})(aQuery);