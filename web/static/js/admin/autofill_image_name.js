/*
 * Used to autofill image names on forms
 * by using image title
 */
(function($){
	var imageNameSource = $('[data-image-name]');
	//sanity check first
	if(imageNameSource.length < 1){
		return;
	}
	//sets a textfield aQuery object sets value to 
	//passed in value
	//if it does not already have a value already
	var autofillTextfield = function(textfield, value){
		//val() is null if unset
		var val = textfield.val();
		if(val && val !== ''){
			return;
		}
		textfield.val(value);
	};
	var FILE_SUFFIXES = ['lg', 'med', 'sm', 'thumb'];

	var TEXTFIELD_TARGETS = ['large', 'medium', 'small', 'thumbnail'].map(function(elem){
		return $('[data-image-' + elem + ']');
	});

	var suffixToImageFilename = function(basename, suffix){
		return basename + '-' + suffix + '.jpg';
	};

	//converts string to lowercase and replaces all spaces and underscores with hyphens
	var urlify = function(text){
		if(!text){
			return '';
		}
		return text.toLowerCase().replace(/&/g, 'and').replace(/@/g, 'at').replace(/[\.]+/g, ' ').replace(/[^a-z0-9-_\s]/g, '').replace(/[^\w\d]+/g, '-').replace(/^-+|-+$/g, '');
	};
	//when focus lost on image name source, autofill targets with pre-generated image name,
	//unless they are already filled
	imageNameSource.on('blur', function(event){
		var imageName = urlify(this.value);
		var fileNames = FILE_SUFFIXES.map(function(suffix){
			return imageName + '-' + suffix + '.jpg';
		});

		TEXTFIELD_TARGETS.forEach(function(textfield, i){
			autofillTextfield(textfield, suffixToImageFilename(imageName, FILE_SUFFIXES[i]));
		});
		
	});

})(aQuery);