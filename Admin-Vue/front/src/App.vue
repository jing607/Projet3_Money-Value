<template>
  <div id="app">
  <div><NavBar /></div> 
    <div><router-view /></div>
  </div>
    
</template>



<script>
import NavBar from './components/NavBar.vue'
import { useStore } from 'vuex'

export default {
  name: 'App',
  components: {
    NavBar,
  },

  beforeCreate() { // synch le store avec sa sauvegarde dans localstorage
    const store = useStore()
    store.commit('loadStore');
    
  },
  created() {
    console.log('app', this.$store.state.user)
    if(!this.$store.state.user) {
      this.$store.dispatch('checkAuthenticated')
    }
  }
}
</script>



<style>
  @import url('https://fonts.googleapis.com/css?family=Fira+Sans:400,500,600,700,800');

  * {
    box-sizing: border-box;
  }

  body {
    background: #dfefff !important;
    min-height: 100vh;
    display: flex;
    font-weight: 400;
    font-family: 'Fira Sans', sans-serif;
  }

  h1, h2, h3, h4, h5, h6, label, span {
    font-weight: 500;
    font-family: 'Fira Sans', sans-serif;
  }

  body, html, #app, #root, .auth-wrapper {
    width: 100%;
    height: 100%;
  }

  #app {
    text-align: center;
  }

  .navbar-light {
    background-color: #fff;
    box-shadow: 0px 14px 80px rgba(34, 35, 58, 0.2);
  }

  .auth-wrapper {
    display: flex;
    justify-content: center;
    flex-direction: column;
    text-align: left;
    height: 100vh;
  }

  .auth-inner {
    width: 450px;
    margin: auto;
    background: #fff;
    box-shadow: 0px 14px 80px rgba(34, 35, 58, 0.2);
    padding: 40px 55px 45px 55px;
    border-radius: 15px;
    transition: all .3s;
  }

  .auth-wrapper .form-control:focus {
    background-color: #167bff;
    box-shadow: none;
  }

  .auth-wrapper h3 {
    text-align: center;
    margin: 0;
    line-height: 1;
    padding-bottom: 20px;
  }

  .custom-control-label {
    font-weight: 400;
  }

  .forgot-password,
  .forgot-password a {
    text-align: right;
    font-size: 13px;
    padding-top: 10px;
    color: #7f7d7d;
    margin: 0;
  }

  .forgot-password a {
    color: #167bff;
  }

  .success {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    border: 1px solid green;
    background: rgba(14, 69, 14, 0.6);
    padding: 10px 20px;
    color: white;
    border-radius: 4px;
    cursor: pointer;
    z-index: 7;
  }
</style>
