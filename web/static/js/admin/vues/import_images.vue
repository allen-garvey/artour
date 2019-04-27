<template>
<div class="import-images-container">
    <!-- File input -->
    <div v-if="imageFiles.length < 1">
        <input type="file" multiple ref="fileInput" id="file_input" @change="filesSelected($event)"/>
        <label for="file_input" @drop.prevent="filesDropped($event)" @dragover.prevent="doNothing()">
            <div>
                <!-- from: https://material.io/tools/icons/?icon=cloud_upload&style=baseline -->
                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"><path d="M0 0h24v24H0z" fill="none"/><path d="M19.35 10.04C18.67 6.59 15.64 4 12 4 9.11 4 6.6 5.64 5.35 8.04 2.34 8.36 0 10.91 0 14c0 3.31 2.69 6 6 6h13c2.76 0 5-2.24 5-5 0-2.64-2.05-4.78-4.65-4.96zM14 13v4h-4v-4H7l5-5 5 5h-3z"/></svg>
                <strong>Choose a file</strong><span> or drag it here</span>
            </div>
        </label>
    </div>

    <!-- File display -->
    <div v-if="imageFiles.length > 0">
        <ul>
            <li v-for="(image, i) in images" :key="i">
                <span>{{image.lg}}</span>
                <span>{{image.med}}</span>
                <span>{{image.sm}}</span>
                <span>{{image.thumbnail}}</span>
                <img :src="image.src" v-if="image.src"/>
            </li>
        </ul>
    </div>
</div>
</template>

<script>
import Vue from 'vue';
import { extractImages } from '../import_images.js';

export default {
    props: {
        csrfToken: {
            type: String,
            required: true,
        },
    },
    created(){
    },
    mounted(){
    },
    data(){
        return {
            imageFiles: [],
            images: [],
        };
    },
    computed: {
    },
    watch: {
        imageFiles(newValue){
            this.images = newValue.map((imageFile, i)=>{
                //preview image based on: https://stackoverflow.com/questions/5802580/html-input-type-file-get-the-image-before-submitting-the-form
                const reader = new FileReader();
                reader.onload = (e)=>{
                    const image = this.images[i];
                    image.src = e.target.result;
                    Vue.set(this.images, i, image);
                };
                reader.readAsDataURL(imageFile.file);
                return {
                    lg: imageFile.lg || imageFile.med,
                    med: imageFile.med,
                    sm: imageFile.sm,
                    thumbnail: imageFile.thumb,
                };
            });
        }
    },
    methods: {
        doNothing(){

        },
        filesSelected(event){
            this.imageFiles = extractImages(this.$refs.fileInput.files);
        },
        filesDropped(event){
            this.imageFiles = extractImages(event.dataTransfer.files);
        }
    }
};
</script>