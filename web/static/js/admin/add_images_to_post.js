/*
 * Used for changing styles on post add images page
 * when checkbox is checked
 */
(function($){
	var checkboxSelector = '.post-add-images-list input[type="checkbox"]';
    
    $(checkboxSelector).on('change', function(event){
    	$(this).closest('li').toggleClass('item-selected');
    });

    //for when reloaded the page with checked checkboxes
    $(checkboxSelector).each(function(index, el){
    	if(el.checked){
    		$(el).closest('li').addClass('item-selected');
    	}
    });
})(aQuery);