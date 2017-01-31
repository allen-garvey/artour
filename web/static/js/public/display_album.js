/*
 * Functionality to display album show pages in lightbox
 */
(function($){
    var imageLinks = $('.post-thumbnails a');
    //used to keep track on if an image has been initialized to lightbox already
    //used to lazy-load images
    var imageInitializedMap = imageLinks.map(function(){ return false; });

    function initializeLightbox(numImageLinks){
    	var lightboxContainer = document.createElement('div');
    	lightboxContainer.className = 'lightbox-container hidden';
    	
        var lightboxBackground = document.createElement('div');
    	lightboxBackground.className = 'lightbox-background';
    	lightboxBackground.onclick = hideLightbox;

        var imagesContainer = document.createElement('div');
    	imagesContainer.className = 'lightbox-images-container';
        for(var i=0; i<numImageLinks;i++){
            imagesContainer.appendChild(document.createElement('div'));
        }
    	
        lightboxContainer.appendChild(imagesContainer);
    	lightboxContainer.appendChild(lightboxBackground);
    	document.body.appendChild(lightboxContainer);
    }

    function displayLightbox(imageIndex){
        var parentSelector = '.lightbox-images-container>*:nth-child('+(imageIndex + 1) + ')';
        //initialize img tag if necessary
        if(!imageInitializedMap[imageIndex]){
            imageInitializedMap[imageIndex] = true;
            var imageLink = $(imageLinks.elementList[imageIndex]);
            var imgTag = document.createElement('img');
            imgTag.src = imageLink.data('src');
            imgTag.srcset = imageLink.data('srcset');
            document.querySelector(parentSelector).appendChild(imgTag);
        }
        $('.lightbox-images-container>*').addClass('hidden');
        $(parentSelector).removeClass('hidden');
        $('.lightbox-container').removeClass('hidden');
    }

    function hideLightbox(){
        $('.lightbox-container').addClass('hidden');
    }

    function initializeImageLinkClickHandlers(imageLinks){
        //can't use on function since we need index
        imageLinks.each(function(i, el){
            el.onclick = function(e){
                e.preventDefault();
                displayLightbox(i);
            };
        });
    }

    document.onkeydown = function(e) {
        if(e.keyCode == 27){ // escape key maps to keycode `27`
            hideLightbox();
        }
    };

    initializeLightbox(imageLinks.length);
    initializeImageLinkClickHandlers(imageLinks);


})(aQuery);