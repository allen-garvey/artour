/*
 * Used for changing styles on post add images page
 * when checkbox is checked
 */
(function($){
    $('input[type="checkbox"]').on('change', function(event){
    	$(this).closest('li').toggleClass('item-selected');
    });
})(aQuery);