/*
 * Used to autofill image names on forms
 * by using image title
 */
(function($){
	const imageNameSource = $('[data-image-name]');
	//sanity check first
	if(imageNameSource.length < 1){
		return;
	}

	const isPortraitCheckbox = document.getElementById('is_portrait_checkbox');
	const FILE_SUFFIXES = ['lg', 'med', 'sm', 'thumb'];
	const FILE_SUFFIXES_PORTRAIT = ['med', 'med', 'sm', 'thumb'];

	const TEXTFIELD_TARGETS = ['large', 'medium', 'small', 'thumbnail'].map(function(elem){
		return document.querySelector('[data-image-' + elem + ']');
	});
	
	//sets a textfield element value to 
	//passed in value
	//if it does not already have a value already
	function autofillTextfield(textfield, value){
		//val() is null if unset
		const val = textfield.value;
		if(val){
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

	function autofillFields(inputText){
		//don't do anything if input is blank
		if(!inputText){
			return;
		}
		const imageName = urlify(inputText);
		const fileSuffixes = isPortraitCheckbox.checked ? FILE_SUFFIXES_PORTRAIT : FILE_SUFFIXES;

		TEXTFIELD_TARGETS.forEach(function(textfield, i){
			autofillTextfield(textfield, suffixToImageFilename(imageName, fileSuffixes[i]));
		});
	}


	//when focus lost on image name source, autofill targets with pre-generated image name,
	//unless they are already filled
	imageNameSource.on('blur', function(event){
		autofillFields(this.value);
	});

})(aQuery);