/*
 * Used to reorder images on post show pages
 */
(function($){
	var imageListItems = $('.post-album-image-list li');
    //sanity check that we have images to reorder
    if(imageListItems.elementList.length < 1){
    	return;
    }
    //returns index of node in aQuery collection
    //element is raw DOM node
    //$elements is aQuery object
    var indexOfElement = function(element, $elements){
    	var index = -1;
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
    var reorderListItems = function(originalIndex, newIndex){
    	//don't do anything if item not moved
    	if(originalIndex === newIndex){
    		return;
    	}
    	var movedElement = imageListItems.elementList[originalIndex];
    	var draggedOverElement = imageListItems.elementList[newIndex]
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

    var removeDragPlaceholders = function(listItems){
    	listItems.removeClass('dragged-over-from-top').removeClass('dragged-over-from-bottom')
    }

    //this is used to keep track of the current list item
    //whose handle we are currently using, and disable dragging if we
    //don't use the handles
    //based on: http://stackoverflow.com/questions/26283661/drag-drop-with-handle
    var clickTarget = null;
    var currentlyDraggedItemIndex = null;
    var currentlyDraggedOverIndex = null;
    
    //used to keep track if drag was caused by clicking on handle
    imageListItems.on('mousedown', function(event) {
    	clickTarget = event.target;
    });

    imageListItems.on('dragstart', function(event) {
    	var handle = $(this).find('.list-item-dragger');
    	//see if drag was caused by clicking on handle
    	if(!handle.elementList[0].contains(clickTarget)){
    		event.preventDefault();
    		return;
    	}
    	currentlyDraggedItemIndex = indexOfElement(this, imageListItems);
    });

    imageListItems.on('dragover', function(event) {
    	//required so drop events fire
    	event.preventDefault();
    	//required to get actual li, and not part of li that was dragged over
    	var listItemDraggedOver = $(this).closest('[draggable="true"]')
    	currentlyDraggedOverIndex = indexOfElement(listItemDraggedOver.elementList[0], imageListItems);
    	//remove placeholders
    	removeDragPlaceholders(imageListItems);
    	//don't add drop placeholder if we are dragging an item over itself
    	if(currentlyDraggedItemIndex === currentlyDraggedOverIndex){
    		return;
    	}
    	else if(currentlyDraggedOverIndex !== 1 || currentlyDraggedOverIndex > currentlyDraggedOverIndex){
    		listItemDraggedOver.addClass('dragged-over-from-bottom');
    	}
    	else{
    		listItemDraggedOver.addClass('dragged-over-from-top');
    	}
    });

    imageListItems.on('dragend', function(event) {
    	event.preventDefault();
    	//remove placeholders
    	removeDragPlaceholders(imageListItems);
    	reorderListItems(currentlyDraggedItemIndex, currentlyDraggedOverIndex);
    	//show save button if reordered at least once
    	if(currentlyDraggedItemIndex !== currentlyDraggedOverIndex){
    		$('.post-album-image-list-controls').removeClass('hidden');
    	}
    });



})(aQuery);