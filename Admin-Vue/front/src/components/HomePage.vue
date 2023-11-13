<template>

    <div class="auth-wrapper" v-if="!user">
      <div class="auth-inner">
            <div>
                <h3 >You are not logged in</h3>
            </div>
        </div>
    </div>

    <div class="top-container d-flex flex-row justify-content-around align-items-start flex-wrap text-start mt-5">
        
        <div class="cur-list position-relative">
            <div class="success" v-if="showCurSuccess" @click="hideCurSuccess()">{{ addNotif }}</div>
            <div class="card">
                <div class="card-header">
                    <h4>
                        Currency List
                        <button class="btn btn-primary float-end"  @click="curModalAddShow()">
                            Add a currency
                        </button>
                    </h4>
                </div>
                <div class="card-body">
                    <table class="table table-bordered">
                        <thead>
                            <tr>
                                <th>Code</th>
                                <th>Name</th>
                                <th>Symbol</th>
                                <th colspan="2"><em>Action</em></th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr v-for="cur in curList" :key="cur.id">
                                <td>{{cur.code}}</td>
                                <td><em>{{cur.full_name}}</em></td>
                                <td>{{cur.symbol}}</td>
                                <td><button class="btn btn-warning float-end" @click="curModalEditShow(cur)">edit</button></td>
                                <td><button type="button" @click="deleteCur(cur.id)" class="btn btn-danger float-end">delete</button></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <PairComponent />
    </div>



    <!-- Add new currency modal  -->
    <div class="calque" v-if="showCurModal" @click="hideCurModal()">
        <div id="currencyModal" v-if="showCurModal"  class="modal fade show" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" @click.stop>
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 v-if="addMode" class="modal-title fs-5" id="exampleModalLabel">Add a currency</h1>
                        <h1 v-else class="modal-title fs-5" id="exampleModalLabel">Edit a currency</h1>
                        <button type="button" class="btn-close" @click="hideCurModal()" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form @submit.prevent="handleSubmitCur(addMode)" class="text-start">
                            <ErrorAlert v-if="error.length" :error="error" />

                            <div class="form-group">
                                <label>Full Name <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" v-model="full_name" placeholder="full name" required>
                            </div>
                            
                            <div class="form-group mt-2">
                                <label>Code <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" v-model="code" placeholder="Code"  required>
                            </div>

                            <div class="form-group mt-2">
                                <label>symbol <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" v-model="symbol" placeholder="Password"  required>
                            </div>

                            <!-- <div class="form-group mt-2">
                                <label>Upload a flag <span class="text-danger">*</span></label>
                                <input type="file" class="form-control" >
                            </div> -->
                            <div class="text-center">
                                <button type="submit" class="btn btn-primary mt-3 mb-2 me-3">Save changes</button>
                            </div>
                        </form>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" @click="hideCurModal()">Close</button>
                            <button type="button" class="btn btn-warning" @click="resetCurForm()">Reset</button>
                            
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>



    <div v-if="user" class="top-container d-flex flex-row justify-content-center align-items-center text-start">
        <div class="w25 bg-white">
            <AdminConverter />
        </div> 
    </div>
</template>



<script>
    import axios from 'axios';
    import { mapState } from 'vuex';
    import ErrorAlert from './login/ErrorAlert.vue';
    import AdminConverter from './AdminConverter.vue';
    import PairComponent from './PairComponent.vue';


    export default {
        name: 'HomeComponent',

        components: {
            ErrorAlert,
            AdminConverter,
            PairComponent,
        },

        data() {
            return {
                value: 0,
                result: 0,
                showCurModal: false,
                showPairsModal: false,
                error: [],
                full_name: '',
                code: '',
                symbol: '',
                addNotif: '',
                showCurSuccess: false,
                addMode: false,
            };
        },
        created() {
            if(!this.user) {
                this.$router.push('/login')
            }

            if(!this.curList) {
                this.$store.dispatch('getCurList')
            }
            if(!this.curPairs) {
                this.$store.dispatch('getCurPairs')
            }
        },
        // mounted() {
        //     console.log(this.curPairs)
        // },
        computed: {
            ...mapState(['user', 'curList', 'curPairs']),
            
        },
        methods: {
            async deleteCur(curId) {
                let confirmation = confirm('This action is definitive. Do you want to continue ?')
                if(!confirmation) {
                    return
                }
                axios.delete(`admin/currency/${curId}`).then((res) => {
                    console.log(res)
                    if(res.status === 200) {
                        this.addNotif = 'SUCCESS! Currency correctly deleted!'
                        this.showCurSuccess = true;
                        window.setTimeout(function() {
                            this.showCurSuccess = false
                        }.bind(this), 5000)
                        this.$store.dispatch('getCurList')
                    }
                })
            },
            // fait apparaitre la modale currency en modeAjout
            curModalAddShow() {
                this.addMode = true
                this.showCurModal = true
            },
            // fait apparaitre la modale Currency en Modification
            curModalEditShow(currency) {
                this.addMode = false
                this.full_name = currency.full_name
                this.code = currency.code
                this.symbol = currency.symbol
                this.flag = currency.flag
                this.idToEdit = currency.id
                this.showCurModal = true
            },
            // fait disparaitre la modale currency
            hideCurModal() {
                this.showCurModal = false
            },

            // remet à zéro le formulaire de la modale des currency
            resetCurForm() {
                this.full_name = ''
                this.code = ''
                this.symbol = ''
                this.flag = 'none' // for the moment.... TODO!
            },

            // fait disparaitre la notification de succes d'ajout ou modification 
            // des Currency
            hideCurSuccess() {
                this.showCurSuccess = false
            },

            // dicrimination du traitement à appliquer (ajout vs modif)
            handleSubmitCur(mode) {
                if(mode) {
                    this.handleSubmitAddCurrency()
                } else {
                    this.handleSubmitEditCurrency()
                }
            },


            // Gestionnaire de soumission du formulaire d'ajout 
            // de la modale des currency
            async handleSubmitAddCurrency() {
                if(!this.validateform()) {
                    return;
                }
                // on effectue le call api vers le endpoint /sanctum/csrf-cookie 
                // pour récup le jeton csrf
                try {
                    const csrf = await axios.get('/sanctum/csrf-cookie')
                    // console.log(csrf)
                    if(csrf.status !== 204){
                        throw new Error('Csrf protection disabled!')
                    }

                    // puis on effectue le call api vers le endpoint /register
                    const res = await axios.post('admin/currency', {
                        full_name: this.full_name.trim(),
                        code: this.code.trim(),
                        symbol: this.symbol.trim(),
                        flag: 'none',
                    });

                    if(res.status === 201) {
                        this.hideCurModal()
                        this.addNotif = 'SUCCESS! Currency correctly added!'
                        this.showCurSuccess = true;
                        window.setTimeout(function() {
                            this.showCurSuccess = false
                        }.bind(this), 5000)
                        this.$store.dispatch('getCurList')
                    }
                }catch (e) {
                    // echec: il y a erreur et on l'affiche
                    this.error.push('Error Occured!');
                }
            },

            async handleSubmitEditCurrency() {
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
                    const res = await axios.patch(`admin/currency/${this.idToEdit}`, {
                        full_name: this.full_name.trim(),
                        code: this.code.trim(),
                        symbol: this.symbol.trim(),
                        flag: 'none',
                    });

                    if(res.status === 200) {
                        this.hideCurModal()
                        this.addNotif = 'SUCCESS! Currency updated!'
                        this.showCurSuccess = true;
                        window.setTimeout(function() {
                            this.showCurSuccess = false
                        }.bind(this), 5000)
                        this.$store.dispatch('getCurList')
                    }
                }catch (e) {
                    // echec: il y a erreur et on l'affiche
                    this.error.push('Error Occured!');
                }
            },

            validateform() {
                // méthode de validation des données utilisateurs
                const full_name = this.full_name.trim()
                const code = this.code.trim()
                const symbol = this.symbol.trim()

                // données non vides
                if(
                    full_name=== '' ||
                    code === '' ||
                    symbol === ''
                ) {
                    this.error.push('All fields must be filled.')
                }

                // le champ nams: 3 caractères mini
                if(full_name.length < 2) {
                    this.error.push('the field Full Name must be at least 2 characters long.')
                }
                
                if(code.length > 3) {
                    this.error.push('the field CODE must be 3 characters long max.')
                }

                // password min 5 caractères
                if(symbol.length > 7) {
                    this.error.push('The symbol seems incorrect. Please check.')
                }
                
                return !this.error.length

            },
            // méthode permettant de vérifier qu'une entrée est un nombre
            isNumeric(n) {
                return !isNaN(parseFloat(n)) && isFinite(n);
            },
        },   
    }
    
</script>

<style scoped>
.top-container {
    min-height: 45vh;
    width: 100%;
}

.cur-list {
    width: 25%;
    max-width: 100%;
    max-height: 400px;
    overflow-x: hidden;
    overflow-y: auto;
}

.w25 {
    padding:15px;
    width: 25%;
    max-width: 100%;
    border-radius: 4px;
}

.wide {
    width: 35%;
}

#currencyModal {
    display: unset;
}

#currencyPairsModal {
    display: unset;
}

.calque {
    position: fixed;
    top: 0;
    left: 0;
    width:100%;
    height:100%;
    z-index:5;
    background: #00000077;
}

.big-font {
    font-size: 32px;
    font-weight: 700;
}

.rate-def {
    font-size: 40px;
    max-width: 45%;
}

.conversion-result {
    font-size: 32px;
    font-weight: 700;
}
</style>