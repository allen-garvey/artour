<template>
    <form accept-charset="UTF-8" :action="formUrl" method="post">
        <input name="_csrf_token" type="hidden" :value="csrfToken">
        <input name="_utf8" type="hidden" value="✓">
        <div class="button-container-right">
            <button type="submit" class="btn btn-primary" :disabled="areAllImagesUnchecked">Save</button>
        </div>
        <ul class="post-add-images-list">
            <li v-for="(image, index) in images" :key="index" :class="{'item-selected': imagesSelected[index]}">
                <div>
                    <label>
                        <input type="checkbox" @change="imageChecked(index)" :checked="imagesSelected[index]" name="images[]" :value="image.id"/>
                        <img :src="image.url.thumbnail" :alt="image.description"/>
                    </label>
                </div>

                <div>
                    <a :href="image.url.self" target="_blank">{{image.title}}</a>
                </div>
            </li>
        </ul>
    </form>

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
        formUrl: {                                                                                                                   
            type: String,                                                                                                                 
            required: true,                                                                                                                
        },
        imagesApiUrl: {                                                                                                                   
            type: String,                                                                                                                 
            required: true,                                                                                                                
        },
    },
    created(){
        fetchJson(this.imagesApiUrl).then((images)=>{
            this.images = images;
            //uncheck all images initially
            this.imagesSelected = images.map(()=>{return false;});
        });
    },
    data(){
        return {
            images: [],
            imagesSelected: [],
        };
    },
    computed: {
        //save button is disabled if every image is unchecked
        areAllImagesUnchecked(){
            return this.imagesSelected.every((value)=>{
                return !value;
            });
        }
    },
    methods: {
        imageChecked(index){
            //need to use vue.set to mutate array directly
            Vue.set(this.imagesSelected, index, !this.imagesSelected[index]);
        }
    },
}
</script>

