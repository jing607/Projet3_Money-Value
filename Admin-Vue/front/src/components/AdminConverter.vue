<template>
  <div>
    <h4 class="text-center">Converter</h4>
    <ErrorAlert v-if="error.length" :error="error" />
    <form @submit.prevent="convert">
        
        <div>
            <label>From currency</label>
            <select class="form-select shadow border dropdown-toggle d-block text-start mb-3" v-model="fromCurrency" name="from_currency" id="from_currency" @change="checkConverter">
                <option value="" :selected="true">--Choose--</option>
                <option v-for="fc of curList" :key="fc.id" :value="fc.code"><strong>{{ fc.code }}</strong>-<em>{{ fc.full_name }}</em></option>
            </select>
        </div>

        <div class="input-group mb-3">
            <input type="text" class="form-control shadow border" v-model.number="amount" placeholder="Amount" aria-label="Amount box" aria-describedby="amount box">
        </div>

        <div class="mt-2">
            <label>To currency</label>
            <select class="form-select shadow border dropdown-toggle d-block text-start" v-model="toCurrency"  name="to_currency" id="to_currency" @change="checkConverter">
                <option value="" :selected="true">--Choose--</option>
                <option v-for="tc of curList" :key="tc.id" :value="tc.code"><strong>{{ tc.code }}</strong>-<em>{{ tc.full_name }}</em></option>
            </select>
        </div>

        <label>=</label>
        <div class="input-group mb-3">
            <input type="text" class="form-control shadow border conversion-result" v-model.number="conversion_result" placeholder="Résults...." aria-label="Results box" aria-describedby="résults box">
        </div>

        <button class="btn btn-primary btn-block mt-3" type="submit" :disabled="converterBtnDisable">convert</button>
    </form>
  </div>
</template>


<script>
  import axios from 'axios';
  import { mapState } from 'vuex';
  import ErrorAlert from './login/ErrorAlert.vue';

  export default {

      name: 'AdminConverter',

      components: {
          ErrorAlert
      },

      data() {
        return({
          error: [],
          fromCurrency:null,
          amount: null,
          toCurrency: null,
          conversion_result: null,
          converterBtnDisable: false,
        })
      },

      created() {
        if(!this.curList) {
            this.$store.dispatch('getCurList')
        }
        if(!this.curPairs) {
            this.$store.dispatch('getCurPairs')
        }
      },
      computed: {
          ...mapState(['curList', 'curPairs']),
          
      },
      methods: {
        // méthode permettant de vérifier qu'une entrée est un nombre
        isNumeric(n) {
            return !isNaN(parseFloat(n)) && isFinite(n);
        },

        checkConverter() {
            if(this.fromCurrency === this.toCurrency) {
                this.converterBtnDisable = true
            } else {
                this.converterBtnDisable = false
            }
        },
        async convert() {
            this.error = []

            if(this.fromCurrency === this.toCurrency) {
                this.conversion_result = 1.00
                return
            }
            if(this.amount < 0) {
                this.amount = -this.amount
            }
            if(!this.isNumeric(this.amount)) {
                return
            }

            // on effectue le call api vers le endpoint api/v1/currency-pairs/convert/{source_currency_code}/{target_currency_code}/{amount} 
            try {

                // puis on effectue le call api vers le endpoint /register
                const res = await axios.get(`api/v1/currency-pairs/convert/${this.fromCurrency}/${this.toCurrency}/${this.amount}`, {});
                // console.log(res)
                if(res.status === 200) {
                    this.conversion_result = `${this.toCurrency} ${res.data.converted_amount.toFixed(4)}`
                }
            }catch (e) {
                // echec: il y a erreur et on l'affiche
                this.error.push('Error Occured!');
            }

        }
      }
  }
</script>


<style scoped>

.conversion-result {
    font-size: 32px;
    font-weight: 700;
}
</style>