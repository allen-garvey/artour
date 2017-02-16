/*
 * Functionality to display album show pages in lightbox
 */
(function($){
    var imageLinks = $('.post-thumbnails a');
    //used to keep track on if an image has been initialized to lightbox already
    //used to lazy-load images
    var imageInitializedMap = imageLinks.map(function(){ return false; });
    var currentImageIndex = null;
    var isLightboxVisible = false;

    function initializeLightbox(numImageLinks){
    	var lightboxContainer = document.createElement('div');
    	lightboxContainer.className = 'lightbox-container hidden';
    	
        var lightboxBackground = document.createElement('div');
    	lightboxBackground.className = 'lightbox-background';
    	lightboxBackground.onclick = hideLightbox;

        var imagesContainer = document.createElement('div');
    	imagesContainer.className = 'lightbox-images-container';
        
        //add empty placeholder divs for images
        //will be lazy loaded by inserting img tag
        //when necessary
        for(var i=0; i<numImageLinks;i++){
            var div = document.createElement('div');
            div.className = 'image-container';
            imagesContainer.appendChild(div);
        }

        //add close 'X' button
        //have to add this after the .image-containers,
        //because nth-child and nth-of-type do not work
        //on class selectors, only elements
        var closeButton = document.createElement('div');
        closeButton.className = 'close-window-button';
        closeButton.onclick = hideLightbox;
        imagesContainer.appendChild(closeButton);

        var rightButton = document.createElement('div');
        rightButton.className = 'slideshow-right-button';
        rightButton.onclick = showNextImage;
        imagesContainer.appendChild(rightButton);

        var leftButton = document.createElement('div');
        leftButton.className = 'slideshow-left-button';
        leftButton.onclick = showPreviousImage;
        imagesContainer.appendChild(leftButton);
    	
        lightboxContainer.appendChild(imagesContainer);
    	lightboxContainer.appendChild(lightboxBackground);
    	document.body.appendChild(lightboxContainer);
    }

    //displays image at index
    //creates img tag if necessary - used for lazy loading
    function setVisibleImageAt(imageIndex){
        currentImageIndex = imageIndex;
        var parentSelector = '.lightbox-images-container>div:nth-child('+(imageIndex + 1) + ')';
        var imageLink = $(imageLinks.elementList[imageIndex]);
        //initialize img tag if necessary
        if(!imageInitializedMap[imageIndex]){
            imageInitializedMap[imageIndex] = true;
            var imgTag = document.createElement('img');
            imgTag.src = imageLink.data('src');
            imgTag.srcset = imageLink.data('srcset');
            document.querySelector(parentSelector).appendChild(imgTag);
        }
        //set image slug in hash url
        window.location.hash = '#' + imageLink.data('slug'); 
        $('.lightbox-images-container>.image-container').addClass('hidden');
        $(parentSelector).removeClass('hidden');
    }

    function displayLightbox(imageIndex){
        isLightboxVisible = true;
        $('.lightbox-container').removeClass('hidden');
    }

    function hideLightbox(){
        isLightboxVisible = false;
        $('.lightbox-container').addClass('hidden');
        //remove image slug from hash url
        window.location.hash = '';
    }

    function initializeImageLinkClickHandlers(imageLinks){
        //can't use on function since we need index
        imageLinks.each(function(i, el){
            el.onclick = function(e){
                e.preventDefault();
                setVisibleImageAt(i);
                displayLightbox();
            };
        });
    }

    function showNextImage(){
        //don't do anything if we are at the last image
        if(currentImageIndex >= imageLinks.length - 1){
            return;
        }
        setVisibleImageAt(currentImageIndex + 1);
    }
    function showPreviousImage(){
        //don't do anything if we are at the first image
        if(currentImageIndex <= 0){
            return;
        }
        setVisibleImageAt(currentImageIndex - 1);

    }

    document.onkeydown = function(e){
        //don't do anything if lightbox is invisible
        if (!isLightboxVisible){
            return;
        }
        if(e.keyCode == 27){ // escape key maps to keycode `27`
            hideLightbox();
        }
        switch(e.keyCode){
            //escape key
            case 27:
                hideLightbox();       
                break;
            //right arrow
            case 39:
                showNextImage();
                break;
            //left arrow
            case 37:
                showPreviousImage();
                break;
        }
    };

    initializeLightbox(imageLinks.length);
    initializeImageLinkClickHandlers(imageLinks);


})(aQuery);