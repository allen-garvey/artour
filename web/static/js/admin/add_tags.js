/*
 * Functionality to add tags to posts
 */
(function($){
	var tagsList = $('.post-tags-list');
	//sanity check to make sure we are on post show page
	if(tagsList.length < 1){
		return;
	}
	//base url used to delete, add, or get list of tags
	var apiUrlBase = tagsList.attr('data-api-url').replace(/\/$/, '');
	var checkboxesContainer = $('.tag-checkboxes');
	var checkboxTemplate = $.template(checkboxesContainer.html());
    
    //get list of unused tags for post and display checkboxes for them
    //or error message if there are no unused tags
    $('[data-role="add-tag-button"]').on('click', function(event){
    	$.ajax({
    		url: apiUrlBase + "/?unused=true",
    		method: 'GET',
    		dataType: 'json',
    		success: function(response){
    			if(response.data && response.data.length > 0){
    				var checkboxes = response.data.map(function(tag){
    					return checkboxTemplate.render({tag_id: tag.id, tag_name: tag.name});
    				}).join('');
    				checkboxesContainer.html(checkboxes);
    				tagsList.attr('data-state', 'add');
    			}
    			else{
    				tagsList.attr('data-state', 'error');
    			}
    		}
    	});
    });
    $('[data-role="cancel-tag-button"]').on('click', function(event){
    	tagsList.attr('data-state', '');
    });

    //remove tag from post and delete list item from DOM
    $('[data-role="delete-tag-button"]').on('click', function(event){
    	var parent = $(this).closest('li');
    	var tagId = parent.data('tag-id');
    	//optimistically react that delete will succeed
    	parent.closest('li').remove();
    	$.ajax({
    		url: apiUrlBase + '/' + tagId,
    		method: 'DELETE',
    		dataType: 'json',
    		success: function(response){
    			if(response.error){
    				console.log(response);
    			}
    		}
    	});

    });


})(aQuery);