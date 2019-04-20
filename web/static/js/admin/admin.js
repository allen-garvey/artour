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

import Vue from 'vue';
import PostAddImagesComponent from './vues/post_add_images_component.vue';
(function(){
    const postAddImagesContainer = document.getElementById('post_add_images_component');
    if(postAddImagesContainer){
        const props = {};
        ['csrfToken', 'formUrl', 'imagesApiUrl'].forEach((key)=>{
            props[key] = postAddImagesContainer.dataset[key];
        });
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
        const props = {};
        ['csrfToken', 'coverImageId', 'postImagesApiUrl', 'editPostApiUrl', 'reorderImagesApiUrl'].forEach((key)=>{
            props[key] = postAlbumListContainer.dataset[key];
        });

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
        const props = {};
        ['csrfToken', 'postId', 'apiBaseUrl', 'newTagUrl'].forEach((propKey)=>{
            props[propKey] = postAddTagsListContainer.dataset[propKey];
        });
        new Vue({
            el: postAddTagsListContainer,
            render: h => h(PostAddTagsList, {props}),
        });
    }
})();