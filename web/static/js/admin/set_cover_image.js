/*
 * Functionality to 
 * make image in album list post cover image
 */
(function($){
    $('[data-role="set-cover-image-button"]').on('click', function(event){
    	var clicked = $(this);
    	var parentList = clicked.closest('.post-album-image-list');
    	var apiUpdateUrl = parentList.data('post-update-url');
    	var parentListItem = clicked.closest('li');
    	var imageId = parentListItem.data('image-id');
    	$.ajax({
    		url: apiUpdateUrl,
    		method: 'PATCH',
    		data: {cover_image_id: imageId},
    		success: function(response){
    			//don't need to do anything
    			//since we are optimistically updating
    		}
    	});
    	//optimistically assume succeeded
    	parentList.find('li').removeClass('cover-image-container');
    	parentListItem.addClass('cover-image-container');
    	
    });
})(aQuery);