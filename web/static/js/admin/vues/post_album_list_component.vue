<template>
    <div>
        <div class="list-group-item-info post-album-image-list-controls" v-show="haveImagesBeenReordered">
            <button class="btn btn-primary">Save Image Order</button>
        </div>
        <ol class="post-album-image-list">
            <li v-for="postImage in postImages" :key="postImage.id" draggable="true" :class="{'cover-image-container': postImage.image.id === coverImageId}">
                <div>
                    <a :href="postImage.image.url.self"><img :src="postImage.image.url.thumbnail" :alt="postImage.image.description"/></a>
                </div>
                <div class="image-title">
                    <a :href="postImage.image.url.self">{{postImage.image.title}}</a>
                    <p v-if="postImage.caption">{{postImage.caption}}</p>
                </div>
                <div class="image-buttons">
                    <a :href="postImage.url.edit" class="btn btn-default">Edit</a>
                    <button class=" btn btn-primary" v-show="postImage.image.id !== coverImageId">Make cover image</button>
                </div>
                <div class="list-item-dragger">&#9776;</div>
            </li>
        </ol>

    </div>
</template>

<script>
import Vue from 'vue';
import { fetchJson } from '../api_helpers.js';

export default {
    props: {
        csrfToken: {                                                                                                                   
            type: String,                                                                                                                 
            required: true,                                                                                                                
        },
        postImagesApiUrl: {                                                                                                               
            type: String,                                                                                                                 
            required: true,                                                                                                                
        },
        coverImageId: {                                                                                                                   
            type: Number,                                                                                                                 
            required: true,                                                                                                                
        },
    },
    created(){
        this.fetchImages();
    },
    data(){
        return {
            postImages: [],
            haveImagesBeenReordered: false,
        };
    },
    computed: {

    },
    watch: {
    },
    methods: {
        fetchImages(){
            return fetchJson(this.postImagesApiUrl).then((postImages)=>{
                this.postImages = postImages;
            });
        }
    },
}
</script>

