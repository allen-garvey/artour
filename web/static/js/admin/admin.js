// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import css from "../../css/admin.scss"

import { initializeAutofillImageName } from './autofill_image_name.js';
initializeAutofillImageName();

import { initializeFormDeleteButton } from './form_delete_button.js';
initializeFormDeleteButton();

import { initializeAutofillSlug } from './slugify.js';
initializeAutofillSlug();

import { initializeVueComponent } from './vue-helpers.js';

import PostAddImagesComponent from './vues/post_add_images_component.vue';
(function(){
    const keys = ['csrfToken', 'formUrl', 'imagesApiUrl'];
    initializeVueComponent('post_add_images_component', PostAddImagesComponent, keys);
})();

import PostAlbumListComponent from './vues/post_album_list_component.vue';
(function(){
    const keys = ['csrfToken', 'coverImageId', 'postImagesApiUrl', 'editPostApiUrl', 'reorderImagesApiUrl'];
    initializeVueComponent('post_album_list_component', PostAlbumListComponent, keys);
})();

import PostAddTagsList from './vues/post_add_tags_list.vue';
(function(){
    const keys = ['csrfToken', 'postId', 'apiBaseUrl', 'newTagUrl'];
    initializeVueComponent('post_add_tags_list', PostAddTagsList, keys);
})();