<template>
    <div class="alert alert-danger" role="alert">
        <p>Errors in your Form. Please correct.</p>
        <ul>
            <li v-for="(item, index) in error" :key="index">{{ item }}}</li>
        </ul>
    </div>
</template>

<script>
    export default {
        name: 'ErrorAlert',
        props: ['error']
    }
</script>