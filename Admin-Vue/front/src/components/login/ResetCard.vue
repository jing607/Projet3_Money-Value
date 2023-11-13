<template>
    <div class="auth-wrapper">
      <div class="auth-inner">
        <form @submit.prevent="handleSubmit">
            <h3>Reset Password</h3>

            <div class="form-group">
                <label>New password</label>
                <input type="password" class="form-control" v-model="password" placeholder="Password">    
            </div>

            <div class="form-group mt-2">
                <label>Password Confirm</label>
                <input type="password" class="form-control" v-model="password_confirm" placeholder="Password">    
            </div>

            <button class="btn btn-primary btn-block mt-3">Submit</button>
        </form>
    </div>
  </div>
</template>



<script>
    import axios from 'axios'

    export default {
        name: 'ResetCard',
        data() {
            return {
                password: '',
                password_confirm: '',
                user: this.$store.state.user
            }
        },
        beforeCreate() {
            this.user = this.$store.state.user
            if(this.user) {
                this.$router.push('/')
            }
        },
        methods:{
            async handleSubmit() {
                const response = await axios.post('reset', {
                    password: this.password,
                    password_confirm: this.password_confirm,
                    token: this.$route.params.token
                });

                console.log(response)
                this.$router.push('/login');
            }
        }
    }
</script>