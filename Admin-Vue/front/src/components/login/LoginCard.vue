<template>
    <div class="auth-wrapper">
      <div class="auth-inner">
        <form @submit.prevent="handleSubmit">
            <ErrorAlert v-if="error.length" :error="error" />
            <h3>Login</h3>

            <div class="form-group">
                <label>Email</label>
                <input type="email" class="form-control" v-model="email" placeholder="Email" required/>
            </div>

            <div class="form-group mt-2">
                <label for="">Password</label>
                <input type="password" class="form-control" v-model="password" placeholder="Password" required/>
            </div>

            <button class="btn btn-primary btn-block mt-3 text-white" type="submit">Envoyer</button>

            <p class="forgot-password text-right">
                <router-link to="forgot">Forgot password?</router-link>
            </p>
        </form>
    </div>
  </div>
</template>



<script>
    import axios from 'axios'
    import ErrorAlert from './ErrorAlert.vue';

    export default {
        name: 'LoginCard',
        components: {
            ErrorAlert
        },
        data() {
            return {
                email: '',
                password: '',
                error: [],
                user: this.$store.state.user
            }
        },
        beforeCreate() {
            this.user = this.$store.state.user
            if(this.user) {
                this.$router.push('/')
            }
        },
        methods: {
            async handleSubmit() {
                // gestionnaire d'évènement click sur le bouton d'envoi du formulaire
                // on nettoit le panneau d'erreur
                this.error = []

                // on fait le call api vers le endpoint /login
                try {
                    const response = await axios.post('auth/login',{
                        email: this.email.trim(),
                        password: this.password.trim()
                    });

                    // si succes:
                    if(response) {
                        console.log(response)
                        if(response.status === 200) {
                            this.$store.commit('addUser', response.data.user)
                            this.$store.commit('setToken', response.data.token)
                            this.$router.push('/');
                        } else {
                            // sinon
                            throw new Error('Invalid username/password')
                        }
                    }

                }catch (e) {
                    // echec et erreur:
                    // console.log(e)
                    this.error.push(e.message)
                }
            }
        },
        mounted() {
            // on effece le panneau d'erreurs
            this.error = []
        }
    }
</script>