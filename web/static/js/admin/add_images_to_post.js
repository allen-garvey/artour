/*
 * Used for changing styles on post add images page
 * when checkbox is checked
 */
(function($){
	var checkboxes = $('.post-add-images-list input[type="checkbox"]');
	//sanity check that we are on the right page
	if(checkboxes.length === 0){
		return;
	}
	var numCheckboxesChecked = 0;
    
    checkboxes.on('change', function(event){
    	$(this).closest('li').toggleClass('item-selected');
    	if(this.checked){
    		numCheckboxesChecked++;
    	}
    	else{
    		numCheckboxesChecked--;
    	}
    	toggleSaveButton(numCheckboxesChecked);
    });

    //for when reloaded the page with checked checkboxes
    checkboxes.each(function(index, el){
    	if(el.checked){
    		$(el).closest('li').addClass('item-selected');
    		numCheckboxesChecked++;
    	}
    });

    //Disables save button if no checkboxes are checked
    function toggleSaveButton(numCheckboxesChecked){
    	var saveButton = document.querySelector('[data-role="save-images"]');
    	if(numCheckboxesChecked === 0){
    		saveButton.disabled = true;
    	}
    	else{
    		saveButton.disabled = false;
    	}
    }
    //toggle save button on startup
    toggleSaveButton(numCheckboxesChecked);
})(aQuery);