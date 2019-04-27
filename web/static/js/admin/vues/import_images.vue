<template>
<div class="import-images-container">
    <div v-if="isInitialLoadComplete && formats.length === 0">Add some formats first</div>
    <div v-if="isInitialLoadComplete && formats.length > 0">
        <!-- File input -->
        <div v-if="imageFiles.length < 1">
            <input type="file" multiple ref="fileInput" id="file_input" @change="filesSelected($event)"/>
            <label for="file_input" :class="fileLabelCLass" @drop.prevent="filesDropped($event)" @dragover.prevent="doNothing()" @dragenter="dragStart()" @dragleave="dragLeave()" @dragend.prevent="dragLeave()">
                <div>
                    <!-- from: https://material.io/tools/icons/?icon=cloud_upload&style=baseline -->
                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"><path d="M0 0h24v24H0z" fill="none"/><path d="M19.35 10.04C18.67 6.59 15.64 4 12 4 9.11 4 6.6 5.64 5.35 8.04 2.34 8.36 0 10.91 0 14c0 3.31 2.69 6 6 6h13c2.76 0 5-2.24 5-5 0-2.64-2.05-4.78-4.65-4.96zM14 13v4h-4v-4H7l5-5 5 5h-3z"/></svg>
                    <strong>Choose a file</strong><span> or drag it here</span>
                </div>
            </label>
        </div>

        <!-- File display -->
        <div v-if="imageFiles.length > 0" class="images-list-container">
            <ul>
                <li v-for="(image, i) in images" :key="i">
                    <div class="image-form">
                        <div class="form-group">
                            <label class="control-label" :for="`image_${i}_title`">Title</label>
                            <input class="form-control" type="text" :id="`image_${i}_title`" :value="image.title" />
                        </div>
                        <div class="form-group">
                            <label class="control-label" :for="`image_${i}_slug`">Slug</label>
                            <input class="form-control" type="text" :id="`image_${i}_slug`" :value="image.slug" />
                        </div>
                        <div class="form-group">
                            <label class="control-label" :for="`image_${i}_description`">Description</label>
                            <input class="form-control" type="text" :id="`image_${i}_description`" />
                        </div>
                        <div class="form-group">
                            <label class="control-label" :for="`image_${i}_format`">Format</label>
                            <select class="form-control" :id="`image_${i}_format`">
                                <option v-for="(format, i) in formats" :key="i">{{format.name}}</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label class="control-label" :for="`image_${i}_completion_date`">Completion date</label>
                            <input class="form-control" type="date" :id="`image_${i}_completion_date`" />
                        </div>
                        <div class="form-group form-group-fixed">
                            <label>Filename large</label>{{image.lg}}
                        </div>
                        <div class="form-group form-group-fixed">
                            <label>Filename medium</label>{{image.med}}
                        </div>
                        <div class="form-group form-group-fixed">
                            <label>Filename small</label>{{image.sm}}
                        </div>
                        <div class="form-group form-group-fixed">
                            <label>Filename thumbnail</label>{{image.thumbnail}}
                        </div>
                    </div>
                    <figure>
                        <img :src="image.src" v-if="image.src"/>
                    </figure>
                </li>
            </ul>
            <div class="button-container"><button class="btn btn-success">Save</button></div>
        </div>
    </div>
</div>
</template>

<script>
import Vue from 'vue';
import { extractImages } from '../import_images.js';
import { fetchJson } from '../ajax.js';

export default {
    props: {
        csrfToken: {
            type: String,
            required: true,
        },
        apiFormatIndexUrl: {
            type: String,
            required: true,
        },
    },
    created(){
        fetchJson(this.apiFormatIndexUrl).then((formats)=>{
            this.formats = formats;
            this.isInitialLoadComplete = true;
        });
    },
    mounted(){
    },
    data(){
        return {
            isInitialLoadComplete: false,
            formats: [],
            imageFiles: [],
            images: [],
            areFilesDraggedOver: false,
        };
    },
    computed: {
        fileLabelCLass(){
            return this.areFilesDraggedOver ? 'dragged-over' : '';
        },
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
                    title: imageFile.title,
                    slug: imageFile.slug,
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
            //required to have drag over do something
        },
        dragStart(){
            this.areFilesDraggedOver = true;
        },
        dragLeave(){
            this.areFilesDraggedOver = false;
        },
        filesSelected(event){
            this.imageFiles = extractImages(this.$refs.fileInput.files);
        },
        filesDropped(event){
            this.areFilesDraggedOver = false;
            this.imageFiles = extractImages(event.dataTransfer.files);
        }
    }
};
</script>