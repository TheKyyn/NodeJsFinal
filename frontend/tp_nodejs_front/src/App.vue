<template>
  <div id="app">
    <AuthComponent v-if="!isAuthenticated" @authenticated="handleAuth" />
    <UserDashboard v-else @authenticated="handleAuth" />
  </div>
</template>

<script>
import AuthComponent from './components/AuthComponent.vue';
import UserDashboard from './components/UserDashboard.vue';

export default {
  data() {
    return {
      isAuthenticated: !!localStorage.getItem('token'),
    };
  },
  components: {
    AuthComponent,
    UserDashboard,
  },
  methods: {
    handleAuth(status) {
      this.isAuthenticated = status;
      if (!status) {
        localStorage.removeItem('token');
      }
    },
  },
};
</script>