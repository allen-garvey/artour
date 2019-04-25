<template>
    <div class="import-images-container">
        <input type="file" multiple ref="fileInput" id="file_input"/>
        <label for="file_input">
            <div>
                <strong>Choose a file</strong><span> or drag it here</span>
            </div>
        </label>
    </div>
</template>

<script>
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
        };
    },
    computed: {
    },
    watch: {
    },
    methods: {
    }
};
</script>