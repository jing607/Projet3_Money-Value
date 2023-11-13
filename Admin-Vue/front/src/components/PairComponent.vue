<template>
  <div class="wide">
    <div class="cur-list  position-relative">
        <div class="success" v-if="showCurPairSuccess" @click="hideCurPairSuccess()">{{ addNotif }}</div>
        <div class="card">
            <div class="card-header">
                <h4>
                    Pair List
                    <button class="btn btn-primary float-end"  @click="curPairsModalAddShow()">
                        Add a pair
                    </button>
                </h4>
            </div>
            <div class="card-body">
                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <th>Cur.1</th>
                            <th>Cur.2</th>
                            <th>Rate</th>
                            <th>Hits</th>
                            <th colspan="2"><em>Action</em></th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr v-for="cur in curPairs" :key="cur.id">
                            <td>{{cur.source_currency.code}}</td>
                            <td>{{cur.target_currency.code}}</td>
                            <td>{{cur.rate}}</td>
                            <td class="text-info">{{cur.hits}}</td>
                            <td><button class="btn btn-warning float-end" @click="curPairsModalEditShow(cur)">edit</button></td>
                            <td><button type="button" @click="deletePairs(cur.id)" class="btn btn-danger float-end">delete</button></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
      </div> 
    <!-- Add new currency Pair modal  -->
    <div class="calque" v-if="showPairsModal" @click="hidePairsModal()">
        <div id="currencyPairsModal" v-if="showPairsModal"  class="modal fade show" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" @click.stop>
                <div class="modal-content">
                <div class="modal-header">
                    <h1 v-if="addMode" class="modal-title fs-5" id="exampleModalLabel">Add a pair</h1>
                    <h1 v-else class="modal-title fs-5" id="exampleModalLabel">Edit a pair</h1>
                    <button type="button" class="btn-close" @click="hidePairsModal()" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form @submit.prevent="handleSubmitCurPair(addMode)" class="text-start">
                        <ErrorAlert v-if="error.length" :error="error" />

                        <div v-if="addMode">
                            <div class="form-group">
                                <label>Source currency <span class="text-danger">*</span></label>
                                <select name="source_currency" id="source-currency" v-model="source_currency" class="btn shadow border dropdown-toggle d-block text-start" @change="checkAddPairsForm">
                                    <option value="" :selected="true">--Choose--</option>
                                    <option v-for="cur in curList" :key="cur.id" :value="cur.id">{{ cur.code }}-{{ cur.full_name }}</option>
                                </select>
                            </div>
                            
                            <div class="form-group mt-3">
                                <label>Target currency <span class="text-danger">*</span></label>
                                <select name="target_currency" id="target-currency" v-model="target_currency" class="btn shadow border dropdown-toggle d-block text-start" @change="checkAddPairsForm">
                                    <option value="" :selected="true">--Choose--</option>
                                    <option v-for="cur in curList" :key="cur.id" :value="cur.id">{{ cur.code }}-{{ cur.full_name }}</option>
                                </select>
                            </div>

                            <div class="form-group mt-3">
                                <label>Rate <span class="text-danger">*</span></label>
                                <input type="number" class="form-control shadow border" v-model="rate" @keyup="checkAddPairsForm" @blur="checkAddPairsForm" step="any" required>
                            </div>
                            <div class="text-center">
                                <button type="submit" class="btn btn-primary mt-4 mb-2 me-3" :disabled="disabledBtn">Save changes</button>
                            </div>
                        </div>

                        <div v-else>
                            <div class="d-flex flex-row justify-content-evenly align-items-center">
                                <span class="big-font">1 {{ source_c }}</span>
                                <span class="big-font"> = </span>
                                <input type="number" class="form-control shadow border rate-def" v-model="rateToEdit" step="any" required>
                                <span class="big-font">{{ target_c }}</span>
                            </div>
                            <div class="text-center">
                                <button type="submit" class="btn btn-primary mt-4 mb-2 me-3">Save changes</button>
                            </div>
                        </div>

                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" @click="hidePairsModal(addMode)">Close</button>
                    <button type="button" class="btn btn-warning" @click="resetCurPairsForm()">Reset</button>
                </div>
                </div>
            </div>
        </div>
    </div>
  </div>
</template>


<script>
  import axios from 'axios';
  import { mapState } from 'vuex';
  import ErrorAlert from './login/ErrorAlert.vue';

  export default {
    name: 'PairComponent',

    components: {
        ErrorAlert,
    },
    data() {
      return {
        showPairsModal: false,
        error: [],
        addNotif: '',
        showCurPairSuccess: false,
        addMode: false,
        idToEdit: null,
        source_currency: '',
        target_currency: '',
        rate: null,
        oldRate:null,
        needsCorrection:false,
        disabledBtn: true,
        source_c: null,
        target_c: null,
        rateToEdit: null,
      }

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

    computed: {
        ...mapState(['user', 'curList', 'curPairs']),
        
    },
    methods: {
      deletePairs(pairId){
        let confirmation = confirm('This action is definitive. Do you want to continue ?')
        if(!confirmation) {
            return
        }
        axios.delete(`admin/currency-pairs/${pairId}`).then((res) => {
            if(res.status === 200) {
                this.hidePairsModal()
                this.addNotif = 'SUCCESS! Currency Pair correctly deleted!'
                this.showCurPairSuccess = true;
                window.setTimeout(function() {
                    this.showCurPairSuccess = false
                }.bind(this), 5000)
                this.$store.dispatch('getCurPairs')
            }
        })
      },
      // fait apparaitre la modale des Pair en Ajout
      curPairsModalAddShow() {
          this.addMode = true
          this.showPairsModal = true
      },
      // fait appraitre la modale des Paires en Modification
      curPairsModalEditShow(currencyPair) {
          this.addMode = false
          this.source_c = this.curList.filter(cur => cur.id === currencyPair.source_currency.id)[0].code
          this.target_c = this.curList.filter(cur => cur.id === currencyPair.target_currency.id)[0].code
          this.rateToEdit = currencyPair.rate
          this.idToEdit = currencyPair.id
          this.showPairsModal = true
      },
      // Fait disparaitre la modale des Paires
      hidePairsModal() {
          this.showPairsModal = false
      },

      // check the add pair form on the fly to decide 
      // wether to activate the submit button or not
      checkAddPairsForm() {

        if(
            this.source_currency === '' || 
            this.target_currency === '' ||
            this.source_currency === this.target_currency ||
            !this.isNumeric(this.rate)
        ) {
            this.disabledBtn = true
        } else {
            this.disabledBtn = false
        }
        let t = this.curPairs.filter(pair => pair.source_currency.id === this.source_currency && pair.target_currency.id === this.target_currency)
        if(t.length) {
            this.error.push('That pair already exists!...')
            if(this.disabledBtn === false) {
                this.disabledBtn = true
            }
            this.oldRate = this.rate
            this.rate = t[0].rate
            this.needsCorrection = true
            
        }else {
          this.error = []
          if(this.needsCorrection) {
              if(!this.oldRate) {
                  this.disabledBtn = true
              }
              this.rate = this.oldRate
              this.oldRate = false
              this.needsCorrection = false
          }
          let t2 = this.curPairs.filter(pair => pair.target_currency.id === this.source_currency && pair.source_currency.id === this.target_currency)
          console.log(t2)
          if(t2.length) {
              this.oldRate = this.rate
              this.disabledBtn = false
              this.rate = (1/t2[0].rate).toFixed(4)
              this.needsCorrection = true
          }
        }
      },
      // remet à zéro le formulaire de la modale des Pairs
      resetCurPairsForm() {
          if(this.addMode) {
              this.rate = ''
              this.source_currency = ''
              this.target_currency = ''
          } else {
              this.rateToEdit = ''
          }
      },
      // fait disparaitre la notification de succes d'ajout ou modification 
      // des Paires
      hideCurPairSuccess() {
          this.showCurPairSuccess = false
      },
      // dicrimination du traitement à appliquer (ajout vs modif)
      handleSubmitCurPair(mode) {
          if(mode) {
              this.handleSubmitAddCurrencyPairs()
          } else {
              this.handleSubmitEditCurrencyPairs()
          }
      },
      // Gestionnaire de soumission du formulaire d'ajout de la 
      // modale des currency Pairs
      async handleSubmitAddCurrencyPairs() {
        this.validateAddPairsform()

        // on effectue le call api vers le endpoint /sanctum/csrf-cookie 
        // pour récup le jeton csrf
        try {
          const csrf = await axios.get('/sanctum/csrf-cookie')
          // console.log(csrf)
          if(csrf.status !== 204){
              throw new Error('Csrf protection disabled!')
          }

          // puis on effectue le call api vers le endpoint /register
          const res = await axios.post('admin/currency-pairs', {
              source_currency: this.source_currency,
              target_currency: this.target_currency,
              rate: this.rate,
              hits: 0
          });

          if(res.status === 201) {
            this.hidePairsModal()
            this.addNotif = 'SUCCESS! Pair correctly added!'
            this.showCurPairSuccess = true;
            window.setTimeout(function() {
                this.showCurPairSuccess = false
            }.bind(this), 5000)
            this.$store.dispatch('getCurPairs')
          }
        }catch (e) {
          // echec: il y a erreur et on l'affiche
          this.error.push('Error Occured!');
        }
      },
      // Validation du formulaire d'ajout des Paires
      validateAddPairsform() {
          this.error = []
          if(this.source_currency === '' || 
              this.target_currency === '') {
              this.error.push('All fields are required')
          }

          if(this.source_currency === this.target_currency) {
              this.error.push('source currency must be different than targer currency')
          }

          if(!this.isNumeric(this.rate)) {
              this.error.push('The rate must be of NUMERIC type')
          }

          let t = this.curPairs.filter(pair => pair.source_currency.id === this.source_currency && pair.target_currency.id === this.target_currency)
          if(t.length) {
              this.error.push('That pair already exists!...')
          }
      },
      async handleSubmitEditCurrencyPairs() {
        if(!this.validateEditPairsForm) {
            return
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
            const res = await axios.patch(`admin/currency-pairs/${this.idToEdit}`, {
                rate: this.rateToEdit,
            });

            if(res.status === 200) {
                this.hidePairsModal()
                this.addNotif = 'SUCCESS! Pair successfully updated!'
                this.showCurPairSuccess = true;
                window.setTimeout(function() {
                    this.showCurPairSuccess = false
                }.bind(this), 5000)
                this.$store.dispatch('getCurPairs')
            }
        }catch (e) {
            // echec: il y a erreur et on l'affiche
            this.error.push('Error Occured!');
        }
      },
      // Validation du formulaire de modification des paires
      validateEditPairsForm() {
        this.error = []
        if(this.ratetoEdit === '') {
            this.error.push('Please enter an exchange rate')
        }
        if(!this.isNumeric(this.rateToEdit)) {
            this.error.push('The rate must be of NUMERIC type')
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



<style>

.top-container {
    min-height: 45vh;
    width: 100%;
}

.cur-list {
    width: 100%;
    max-width: 100%;
    max-height: 400px;
    overflow-x: hidden;
    overflow-y: auto;
}

.w25 {
    padding:15px;
    width: 100%;
    max-width: 100%;
    border-radius: 4px;
}

.wide {
    width: 100%;
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
</style>