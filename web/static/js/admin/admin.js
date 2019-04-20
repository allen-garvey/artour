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

import { extractProps } from './vue-helpers.js';
import Vue from 'vue';
import PostAddImagesComponent from './vues/post_add_images_component.vue';
(function(){
    const postAddImagesContainer = document.getElementById('post_add_images_component');
    if(postAddImagesContainer){
        const keys = ['csrfToken', 'formUrl', 'imagesApiUrl'];
        const props = extractProps(postAddImagesContainer, keys);

        new Vue({
            el: postAddImagesContainer,
            render: h => h(PostAddImagesComponent, {props}),
        });
    }
})();

import PostAlbumListComponent from './vues/post_album_list_component.vue';
(function(){
    const postAlbumListContainer = document.getElementById('post_album_list_component');
    if(postAlbumListContainer){
        const keys = ['csrfToken', 'coverImageId', 'postImagesApiUrl', 'editPostApiUrl', 'reorderImagesApiUrl'];
        const props = extractProps(postAlbumListContainer, keys);

        new Vue({
            el: postAlbumListContainer,
            render: h => h(PostAlbumListComponent, {props}),
        });
    }
})();

import PostAddTagsList from './vues/post_add_tags_list.vue';
(function(){
    const postAddTagsListContainer = document.getElementById('post_add_tags_list');
    if(postAddTagsListContainer){
        const keys = ['csrfToken', 'postId', 'apiBaseUrl', 'newTagUrl'];
        const props = extractProps(postAddTagsListContainer, keys);

        new Vue({
            el: postAddTagsListContainer,
            render: h => h(PostAddTagsList, {props}),
        });
    }
})();