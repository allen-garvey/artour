// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import css from "../../css/admin.scss"

import { initializeAutofillImageName } from './autofill_image_name.js';
initializeAutofillImageName();

import { initializeAddTags } from './add_tags.js';
initializeAddTags();

import { initializeFormDeleteButton } from './form_delete_button.js';
initializeFormDeleteButton();

import { initializeSetCoverImage } from './set_cover_image.js';
initializeSetCoverImage();

import { initializeAutofillSlug } from './slugify.js';
initializeAutofillSlug();

import Vue from 'vue';
import PostAddImagesComponent from './vues/post_add_images_component.vue';
(function(){
    const postAddImagesContainer = document.getElementById('post_add_images_component');
    if(postAddImagesContainer){
        const csrfToken = postAddImagesContainer.dataset.csrfToken;
        const formUrl = postAddImagesContainer.dataset.formUrl;
        const imagesApiUrl = postAddImagesContainer.dataset.imagesApiUrl;
        new Vue({
            el: postAddImagesContainer,
            render: h => h(PostAddImagesComponent, {props: {csrfToken, formUrl, imagesApiUrl}}),
        });
    }
})();

import PostAlbumListComponent from './vues/post_album_list_component.vue';
(function(){
    const postAlbumListContainer = document.getElementById('post_album_list_component');
    if(postAlbumListContainer){
        const csrfToken = postAlbumListContainer.dataset.csrfToken;
        const coverImageId = parseInt(postAlbumListContainer.dataset.coverImageId);
        const postImagesApiUrl = postAlbumListContainer.dataset.postImagesApiUrl;
        new Vue({
            el: postAlbumListContainer,
            render: h => h(PostAlbumListComponent, {props: {csrfToken, coverImageId, postImagesApiUrl}}),
        });
    }
})();