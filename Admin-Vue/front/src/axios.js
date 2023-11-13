import axios from 'axios'

axios.defaults.baseURL = 'http://localhost:8000'
// Ajouter un intercepteur pour les réponses avec le code 401
axios.interceptors.response.use(
  response => response,
  error => {
    // Si la réponse a un code 401 (non autorisé)
    if (error.response.status === 401) {
      localStorage.removeItem('token');
          this.$store.commit('emptyState');
          this.$store.commit('emptyStore');
          this.$router.push('/');
    }
    return Promise.reject(error);
  }
);
axios.defaults.headers.common['Authorization'] = 'Bearer' + localStorage.getItem('token');
axios.defaults.withCredentials = true;