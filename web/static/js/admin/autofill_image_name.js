/*
 * Used to autofill image names on forms
 * by using image title
 */
(function(){
	var imageNameSource = document.querySelector('[data-image-name]');
	//sanity check first
	if(!imageNameSource){
		return;
	}
	var regenerateButton = document.getElementById('autofill-image-button');
	var isPortraitCheckbox = document.getElementById('is_portrait_checkbox');
	var FILE_SUFFIXES = ['lg', 'med', 'sm', 'thumb'];
	var FILE_SUFFIXES_PORTRAIT = ['med', 'med', 'sm', 'thumb'];

	var TEXTFIELD_TARGETS = ['large', 'medium', 'small', 'thumbnail'].map(function(elem){
		return document.querySelector('[data-image-' + elem + ']');
	});
	
	//sets a textfield element value to passed in value
	function autofillTextfield(textfield, value, shouldForce){
		if(!shouldForce && textfield.value){
			return;
		}
		textfield.value = value;
	}
	function suffixToImageFilename(basename, suffix){
		return basename + '-' + suffix + '.jpg';
	}

	//converts string to lowercase and replaces all spaces and underscores with hyphens
	function urlify(text){
		if(!text){
			return '';
		}
		return text.toLowerCase().replace(/&/g, 'and').replace(/@/g, 'at').replace(/[\.]+/g, ' ').replace(/[^a-z0-9-_\s]/g, '').replace(/[^\w\d]+/g, '-').replace(/^-+|-+$/g, '');
	}

	function autofillFields(inputText, shouldForce){
		//don't do anything if input is blank
		if(!inputText){
			return;
		}
		var imageName = urlify(inputText);
		var fileSuffixes = isPortraitCheckbox.checked ? FILE_SUFFIXES_PORTRAIT : FILE_SUFFIXES;

		TEXTFIELD_TARGETS.forEach(function(textfield, i){
			autofillTextfield(textfield, suffixToImageFilename(imageName, fileSuffixes[i]), shouldForce);
		});
	}


	//when focus lost on image name source, autofill targets with pre-generated image name,
	//unless they are already filled
	imageNameSource.addEventListener('blur', function(event){
		autofillFields(this.value, false);
	});

	regenerateButton.onclick = function(){
		autofillFields(imageNameSource.value, true);
	};

})();