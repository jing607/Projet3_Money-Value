<template>
  <nav class="navbar navbar-expand navbar-light">
    <div class="container">
      <router-link to="/" class="navbar-brand">Home</router-link>
      <div class="collapse navbar-collapse">
        <ul class="navbar-nav ml-auto" v-if="!user">
          <li class="nav-item">
            <router-link to="/login" class="nav-link">Login</router-link>
          </li>
          <li class="nav-item">
            <router-link to="/register" class="nav-link">Sign up</router-link>
          </li>
        </ul>

        <ul class="navbar-nav ml-auto" v-if="user">
          <li class="nav-item">
            <a href="javascript:void(0)" @click="handleClick" class="nav-link">Logout</a>
          </li>
        </ul>
      </div>
    </div>
  </nav>
</template>

<script>
import axios from 'axios';
import { mapState } from 'vuex';

export default {
  name: 'NavBar',
  computed: {
    ...mapState(['user']),
  },
  methods: {
    async handleClick() {
      // Appel API vers le endpoint /logout
      try {
        const response = await axios.post('/auth/logout');
        // Si succès
        if (response && response.status === 204) {
          localStorage.removeItem('token');
          this.$store.commit('emptyState');
          this.$store.commit('emptyStore');
          this.$router.go(-1);
        }
      } catch (e) {
        console.error(e);
      }
      this.$router.push('/');
    },
  },
};
</script>
