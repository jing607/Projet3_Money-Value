<template>
    <div class="auth-wrapper">
      <div class="auth-inner">
        <form @submit.prevent="handleSubmit">
            <div v-if="message" class="alert alert-success" role="alert">
                {{ message }}
            </div>

            <ErrorAlert v-if="error" error="error" />
            <!-- <ErrorAlert :error="error"></ErrorAlert> -->

            <h3>Forgot Password</h3>

            <div class="form-group">
                <label>Entre the email you registered with.</label>
                <input type="email" class="form-control" v-model="email" placeholder="Email">
                <small class="text-info"><em>We will send you an email to reset your password.</em></small>    
            </div>

            <button class="btn btn-primary btn-block mt-3">Submit</button>
        </form>
    </div>
  </div>
</template>



<script>
    import axios from 'axios'
    import ErrorAlert from './ErrorAlert.vue';

    export default {
        name: 'ForgotCard',
        components: {
            ErrorAlert
        },
        data() {
            return {
                email: '',
                message: '',
                error: ''
            }
        },
        methods:{
            async handleSubmit() {
                try {
                    await axios.post('forgot', {
                        email: this.email
                    });

                    this.message = 'The email was sent!';
                    this.error = '';
                } catch (e) {
                    this.error = 'Error occured';
                    this.error = '';
                }
            }
        }
    }
</script>