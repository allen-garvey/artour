/*
 * Used to reorder images on post show pages
 */

import { aQuery as $ } from './aquery.js';

export function initializeDragReorderImages(){
	const imageListItems = $('.post-album-image-list li');
    //sanity check that we have images to reorder
    if(imageListItems.elementList.length < 1){
    	return;
    }
    //returns index of node in aQuery collection
    //element is raw DOM node
    //$elements is aQuery object
    const indexOfElement = function(element, $elements){
    	let index = -1;
    	$elements.each(function(i, el){
    		if(el.isSameNode(element)){
    			index = i;
    		}
    	});
    	return index;
    };

    //reorders items in list of aQuery elements
    //original index of item to be moved
    //new index of item to be moved
    //no bounds checking done
    const reorderListItems = function(originalIndex, newIndex){
    	//don't do anything if item not moved
    	if(originalIndex === newIndex){
    		return;
    	}
    	const movedElement = imageListItems.elementList[originalIndex];
    	const draggedOverElement = imageListItems.elementList[newIndex]
    	//remove from dom
    	movedElement.remove();

    	if(originalIndex > newIndex){
    		$(draggedOverElement).before(movedElement);
    		//shuffle up
    	}
    	else{
    		$(draggedOverElement).after(movedElement);
    		//shuffle down
    	}
    	//reset image list items, since we modified it
    	imageListItems = $('.post-album-image-list li');
    }

    const removeDragPlaceholders = function(listItems){
    	listItems.removeClass('dragged-over-from-top').removeClass('dragged-over-from-bottom')
    }

    //this is used to keep track of the current list item
    //whose handle we are currently using, and disable dragging if we
    //don't use the handles
    //based on: http://stackoverflow.com/questions/26283661/drag-drop-with-handle
    let clickTarget = null;
    let currentlyDraggedItemIndex = null;
    let currentlyDraggedOverIndex = null;
    let currentlyDraggingImage = false;
    
    //used to keep track if drag was caused by clicking on handle
    imageListItems.on('mousedown', function(event) {
    	clickTarget = event.target;
    });

    imageListItems.on('dragstart', function(event) {
    	const handle = $(this).find('.list-item-dragger');
        //length will be 0 when dragging image instead of button
        if(handle.length < 1){
            currentlyDraggingImage = true;
            return;
        }
        currentlyDraggingImage = false;
    	//see if drag was caused by clicking on handle
    	if(!handle.elementList[0].contains(clickTarget)){
    		event.preventDefault();
    		return;
    	}
    	currentlyDraggedItemIndex = indexOfElement(this, imageListItems);
    });

    imageListItems.on('dragover', function(event){
        if(currentlyDraggingImage){
            return;
        }
    	//required so drop events fire
    	event.preventDefault();
    	//required to get actual li, and not part of li that was dragged over
    	const listItemDraggedOver = $(this).closest('[draggable="true"]')
    	currentlyDraggedOverIndex = indexOfElement(listItemDraggedOver.elementList[0], imageListItems);
    	//remove placeholders
    	removeDragPlaceholders(imageListItems);
    	//don't add drop placeholder if we are dragging an item over itself
    	if(currentlyDraggedItemIndex === currentlyDraggedOverIndex){
    		return;
    	}
    	else if(currentlyDraggedOverIndex < currentlyDraggedItemIndex){
    		listItemDraggedOver.addClass('dragged-over-from-bottom');
    	}
    	else{
    		listItemDraggedOver.addClass('dragged-over-from-top');
    	}
    });

    imageListItems.on('dragend', function(event){
        if(currentlyDraggingImage){
            return;
        }
    	event.preventDefault();
    	//remove placeholders
    	removeDragPlaceholders(imageListItems);
    	reorderListItems(currentlyDraggedItemIndex, currentlyDraggedOverIndex);
    	//show save button if reordered at least once
    	if(currentlyDraggedItemIndex !== currentlyDraggedOverIndex){
    		$('.post-album-image-list-controls').removeClass('hidden');
    	}
    });

    $('[data-role="save-image-order-button"]').on('click', function(event) {
    	const apiReorderImageUrl = $('.post-album-image-list').data('reorder-images-url');
    	const imageIds = $('.post-album-image-list li').map(function(el){ return $(el).data('image-id'); });
    	$.ajax({
    		url: apiReorderImageUrl,
    		method: 'PATCH',
    		dataType: 'json',
    		data: {images: imageIds},
    		success: function(response){
    			//no action necessary
    		}
    	});
    	//rehide save button
    	$('.post-album-image-list-controls').addClass('hidden');
    });



}