/*
 * Functionality to 
 * make image in album list post cover image
 */

import { aQuery as $ } from './aquery.js';

export function initializeSetCoverImage(){
    $('[data-role="set-cover-image-button"]').on('click', function(event){
    	const clicked = $(this);
    	const parentList = clicked.closest('.post-album-image-list');
    	const apiUpdateUrl = parentList.data('post-update-url');
    	const parentListItem = clicked.closest('li');
    	const imageId = parentListItem.data('image-id');
    	$.ajax({
    		url: apiUpdateUrl,
    		method: 'PATCH',
    		data: {cover_image_id: imageId},
    		success: (response)=>{
    			//don't need to do anything
    			//since we are optimistically updating
    		}
    	});
    	//optimistically assume succeeded
    	parentList.find('li').removeClass('cover-image-container');
    	parentListItem.addClass('cover-image-container');
    	
    });
}