<template>
    <div class="auth-wrapper">
      <div class="auth-inner">
        <form @submit.prevent="handleSubmit">
            <ErrorAlert v-if="error.length" :error="error" />
            <h3>Sign up</h3>

            <div class="form-group">
                <label>Name <span class="text-danger">*</span></label>
                <input type="text" class="form-control" v-model="name" placeholder="First Name" required>
            </div>
            
            <div class="form-group mt-2">
                <label>Email <span class="text-danger">*</span></label>
                <input type="email" class="form-control" v-model="email" placeholder="Email"  required>
            </div>

            <div class="form-group mt-2">
                <label>Password <span class="text-danger">*</span></label>
                <input type="password" class="form-control" v-model="password" placeholder="Password"  required>
            </div>

            <div class="form-group mt-2">
                <label>Confirm Password <span class="text-danger">*</span></label>
                <input type="password" class="form-control" v-model="password_confirm" placeholder="Confirm Password"  required>
            </div>

            <button class="btn btn-primary btn-block mt-3">Sign Up</button>
        </form>
    </div>
  </div>
</template>

<script>
    import axios from 'axios'
    import ErrorAlert from './ErrorAlert.vue';

    export default {
        name: 'RegisterCard',
        components: {
            ErrorAlert
        },
        data() {
            return {
                name: '',
                email: '',
                password: '',
                password_confirm: '',
                error: [],
                user: this.$store.state.user,
            }
        },
        beforeCreate() {
            this.user = this.$store.state.user
            if(this.user) {
                this.$router.push('/')
            }
        },
        methods: {
            async handleSubmit(){
                // gestionnaire du cliclk sur le bouton d'envoi du formulaire:
                // si la validation ne passe pas on sort
                if(!this.validateform()) {
                    return;
                }

                // on effectue le call api vers le endpoint /sanctum/csrf-cookie pour récup 
                // le jeton csrf
                try {
                    const csrf = await axios.get('/sanctum/csrf-cookie')
                    // console.log(csrf)
                    if(csrf.status !== 204){
                        throw new Error('Csrf protection disabled!')
                    }

                    // puis on effectue le call api vers le endpoint /register
                    const res = await axios.post('register', {
                        name: this.name.trim(),
                        email: this.email.trim(),
                        password: this.password.trim(),
                        password_confirmation: this.password_confirm.trim(),
                    }, 
                    // {
                    //     headers: {
                    //         'X-XSRF-TOKEN': (() => {
                    //             const name = 'XSRF-TOKEN'
                    //             const cookies = '; ' + document.cookie
                    //             const parts = cookies.split('; ' + name + '=')
                    //             const value = parts.length == 2 ? parts.pop().split(';').shift() : null

                    //             console.log('>>> XSRF-TOKEN', value)

                    //             return value
                    //         })(),
                    //         'X-Requested-With': 'XMLHttpRequest',
                    //     },
                    // }
                    );

                    if(res) {
                        console.log(res);
                    }

                    // succes: on redirige vers la page de /login
                    this.$router.push('/login');
                }catch (e) {
                    // echec: il y a erreur et on l'affiche
                    this.error.push('Error Occured!');
                }
            },
            validateform() {
                // méthode de validation des données utilisateurs
                const name = this.name.trim()
                const email = this.email.trim()
                const password = this.password.trim()
                const password_confirmation = this.password_confirm.trim()

                // données non vides
                if(
                    name=== '' ||
                    email === '' ||
                    password === '' ||
                    password_confirmation === ''
                ) {
                    this.error.push('All fields must be filled.')
                }

                // le champ nams: 3 caractères mini
                if(name.length < 3) {
                    this.error.push('the field NAME must be at least 3 characters long.')
                }
                
                // validation d'email
                if(!this.isValidEmail(email)) {
                    this.error.push('Please enter a valid email.')
                }

                // password min 5 caractères
                if(password.length < 5) {
                    this.error.push('Passwords have at least 6 characters')
                }

                // password et password_confirmation doivent être identiques
                if(password !== password_confirmation) {
                    this.error.push('Passwords must be identical!')
                }
                
                return !this.error.length

            },
            isValidEmail(email) {
                // verification d'émail par regexp
                const emailRegex = /^\w+([.-]?\w+)*@\w+([.-]?\w+)*(\.\w{2,3})+$/;
                return emailRegex.test(email);
            },
        },
        mounted() {
            // interdit l'acces si 'lutilisateur est loggé
            if(this.user) {
                this.$router.push('/')
            }
        },
    }
</script>