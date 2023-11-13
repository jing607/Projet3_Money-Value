import { createApp } from 'vue'
import App from './App.vue'
import Vuex from 'vuex'


createApp(App).use(Vuex);

const state = {
    user: null
}

const store = new Vuex.Store({
    state,
    getters: {
        user: (state) => {
            return state.user;
        }
    },
    actions: {
        user(context, user){
            context.commit('user', user);
        } 
    },
    mutations: {
        user(state, user){
            state.user = user;
        
        }
    }


});

export default store;
