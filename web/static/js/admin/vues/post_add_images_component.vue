<template>
    <form accept-charset="UTF-8" :action="formUrl" method="post">
        <input name="_csrf_token" type="hidden" :value="csrfToken">
        <input name="_utf8" type="hidden" value="✓">
        <div class="button-container-right">
            <button type="submit" class="btn btn-primary" :disabled="isSaveButtonDisabled">Save</button>
        </div>
        <ul class="post-add-images-list">
            <li v-for="(image, index) in images" :key="index">
                <div>
                    <label>
                    </label>
                </div>

                <div>
                </div>
            </li>
        </ul>
    </form>

</template>

<script>
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

    },
    data(){
        return {
            images: [],
            imagesSelected: [],
        };
    },
    computed: {
        isSaveButtonDisabled(){
            return this.imagesSelected.some((value)=>{
                return value;
            });
        }
    },
}
</script>

