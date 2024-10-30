<template>
  <div>
    <h2>Tableau de bord utilisateur</h2>
    <p>Interface en cours de développement.</p>
    <div class="quota">
      <h3>Quota d'espace utilisé</h3>
      <p>{{ quotaUsed }} / {{ quotaMax }} ({{ quotaPercentage }}%)</p>
    </div>
  </div>
</template>

<script>
export default {
  name: "UserDashboard",
  data() {
    return {
      quotaUsed: 0,
      quotaMax: 2 * 1024 * 1024 * 1024,
    };
  },
  computed: {
    quotaPercentage() {
      return ((this.quotaUsed / this.quotaMax) * 100).toFixed(2);
    },
  },
  async created() {
    try {
      const response = await fetch('http://localhost:3000/api/files/quota', {
        headers: {
          Authorization: `Bearer ${localStorage.getItem('token')}`,
        },
      });
      if (response.ok) {
        const data = await response.json();
        this.quotaUsed = data.quotaUsed;
        this.quotaMax = data.quotaMax;
      } else {
        console.error('Erreur lors de la récupération du quota');
      }
    } catch (error) {
      console.error('Erreur lors de la requête de quota:', error);
    }
  },
};
</script>

<style scoped>
.quota {
  margin-top: 1rem;
  padding: 1rem;
  border: 1px solid #ddd;
  border-radius: 8px;
  background-color: #f9f9f9;
}
</style>
