// import Vue from 'vue'
// import Router from 'vue-router'
import { createRouter, createWebHistory } from 'vue-router'
import HomeComponent from './components/HomePage.vue'
import LoginCard from './components/login/LoginCard.vue'
import RegisterCard from './components/login/RegisterCard.vue'
import ForgotCard from './components/login/ForgotCard.vue'
import ResetCard from './components/login/ResetCard.vue'


const router = createRouter({
    history: createWebHistory(),
    routes: [
        {path: '/', component: HomeComponent,},
        {path: '/login', component: LoginCard},
        {path: '/register', component: RegisterCard},
        {path: '/forgot', component: ForgotCard},
        {path: '/reset-password', component: ResetCard},
    ]
  })

export default router
