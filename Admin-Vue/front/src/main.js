import { createApp } from 'vue'
import App from './App.vue'
import router from './router'
import './axios'
import { createStore } from 'vuex'
import axios from 'axios'


// Vue.config.productionTip = false

const store = createStore({
  state () {
    return {
      user: null,
      token: null,
      curList: null,
      curPairs: null,
    }
  },
  mutations: {
    loadStore() {
      if(localStorage.getItem('valueMoneyStore')) {
          try {
              this.replaceState(JSON.parse(localStorage.getItem('valueMoneyStore')));
          }
          catch(e) {
              console.log('Could not initialize store', e);
          }
      }
    },
    emptyState(state) {
      state.user = null
      state.token = null
      state.curList = null
      state.curPairs = null
    },
    emptyStore(state) {
      if(localStorage.getItem('store')) {
        try {
            this.emptyState(state)
            this.replaceState(JSON.parse(localStorage.getItem('store')));
        }
        catch(e) {
            console.log('Could not empty store', e);
        }
      }
    },
    addUser (state, user) {
      state.user = user
    },
    setToken(state, token) {
      state.token = token
    },
    setCurList(state, list) {
      state.curList = list
    },
    setcurPairs(state, pairs) {
      state.curPairs = pairs
    }
  },
  actions: {
    async checkAuthenticated (context) {
      try{
        const res = await axios.get('auth/user');
        
        if(res.response?.status === 401) {
          return;
        } else {
          console.log(res);
          context.commit('addUser', res.data);
        }
      } catch(e) {
        console.log(e)
      }
    },

    async getCurList(context) {
      try {
        const res = await axios.get('admin/currency')
        console.log(res)
        if(res.status === 200) {
          localStorage.setItem('curList', JSON.stringify(res.data))
          context.commit('setCurList', res.data)
        }
      } catch(e) {
        console.log(e)
      }
    },

    async getCurPairs(context) {
      try {
        const res = await axios.get('admin/currency-pairs')
        console.log(res)
        if(res.status === 200) {
          localStorage.setItem('curPairs', JSON.stringify(res.data))
          context.commit('setcurPairs', res.data)
        }
      } catch(e) {
        console.log(e)
      }
    },

  }
})

store.subscribe((mutation, state) => {
  localStorage.setItem('valueMoneyStore', JSON.stringify(state));
})

const app = createApp(App)
app.use(store)
app.use(router)
app.mount('#app')