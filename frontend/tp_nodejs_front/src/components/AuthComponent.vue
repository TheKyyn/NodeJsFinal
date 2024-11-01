<template>
  <div class="auth-container">
    <div v-if="isLogin">
      <h2>Connexion</h2>
      <form @submit.prevent="login">
        <input type="email" v-model="email" placeholder="Email" required />
        <input type="password" v-model="password" placeholder="Mot de passe" required />
        <button type="submit">Se connecter</button>
      </form>
      <p>Pas encore de compte ? <span @click="toggleAuth">S'inscrire</span></p>
    </div>

    <div v-else>
      <h2>Inscription</h2>
      <form @submit.prevent="register">
        <input type="text" v-model="username" placeholder="Nom d'utilisateur" required />
        <input type="email" v-model="email" placeholder="Email" required />
        <input type="password" v-model="password" placeholder="Mot de passe" required />
        <button type="submit">S'inscrire</button>
      </form>
      <p>Déjà un compte ? <span @click="toggleAuth">Se connecter</span></p>
    </div>
  </div>
</template>

<script>
const backendURL = window.location.hostname === 'localhost' ? 'http://localhost:3000' : 'http://backend:3000';

export default {
  name: "AuthComponent",
  data() {
    return {
      isLogin: true,
      email: '',
      password: '',
      username: '',
    };
  },
  methods: {
    toggleAuth() {
      this.isLogin = !this.isLogin;
    },
    async login() {
      try {
        const response = await fetch(`${backendURL}/api/auth/login`, {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
          },
          body: JSON.stringify({
            email: this.email,
            password: this.password,
          }),
        });
        const data = await response.json();
        if (response.ok) {
          localStorage.setItem('token', data.token);
          this.$emit('authenticated', true);
        } else {
          alert(data.message || 'Erreur de connexion');
        }
      } catch (error) {
        console.error('Erreur lors de la connexion:', error);
      }
    },
    async register() {
      try {
        const response = await fetch(`${backendURL}/api/auth/register`, {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
          },
          body: JSON.stringify({
            username: this.username,
            email: this.email,
            password: this.password,
          }),
        });
        const data = await response.json();
        if (response.ok) {
          alert('Inscription réussie, vous pouvez maintenant vous connecter');
          this.toggleAuth();
        } else {
          alert(data.message || 'Erreur d\'inscription');
        }
      } catch (error) {
        console.error('Erreur lors de l\'inscription:', error);
      }
    },
  },
};
</script>

<style scoped>
.auth-container {
  max-width: 400px;
  margin: auto;
  padding: 2rem;
  border: 1px solid #e5e7eb;
  border-radius: 8px;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}
input {
  width: 100%;
  padding: 0.5rem;
  margin: 0.5rem 0;
  border: 1px solid #ddd;
  border-radius: 4px;
}
button {
  width: 100%;
  padding: 0.75rem;
  margin-top: 1rem;
  background-color: #4f46e5;
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}
button:hover {
  background-color: #4338ca;
}
span {
  color: #4f46e5;
  cursor: pointer;
}
</style>
