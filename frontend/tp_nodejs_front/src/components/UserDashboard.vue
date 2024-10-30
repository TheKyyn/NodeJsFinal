<template>
  <div>
    <h2>Tableau de bord utilisateur</h2>
    <p>Interface en cours de développement.</p>

    <div class="quota">
      <h3>Quota d'espace utilisé</h3>
      <p>{{ quotaUsed }} / {{ quotaMax }} ({{ quotaPercentage }}%)</p>
    </div>

    <div class="files-list">
      <h3>Vos fichiers</h3>
      <table>
        <thead>
        <tr>
          <th>Nom du fichier</th>
          <th>Taille</th>
          <th>Date d'upload</th>
          <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <tr v-for="file in files" :key="file.id">
          <td>{{ file.filename }}</td>
          <td>{{ formatFileSize(file.filesize) }}</td>
          <td>{{ formatDate(file.upload_date) }}</td>
          <td>
            <button @click="downloadFile(file.id)">Télécharger</button>
            <button @click="deleteFile(file.id)">Supprimer</button>
            <button @click="generateShareLink(file.id)">Partager</button>
          </td>
        </tr>
        </tbody>
      </table>
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
      files: [],
    };
  },
  computed: {
    quotaPercentage() {
      return ((this.quotaUsed / this.quotaMax) * 100).toFixed(2);
    },
  },
  async created() {
    try {
      const quotaResponse = await fetch('http://localhost:3000/api/files/quota', {
        headers: {
          Authorization: `Bearer ${localStorage.getItem('token')}`,
        },
      });
      if (quotaResponse.ok) {
        const quotaData = await quotaResponse.json();
        this.quotaUsed = quotaData.quotaUsed;
        this.quotaMax = quotaData.quotaMax;
      } else {
        console.error('Erreur lors de la récupération du quota');
      }

      const filesResponse = await fetch('http://localhost:3000/api/files/list', {
        headers: {
          Authorization: `Bearer ${localStorage.getItem('token')}`,
        },
      });
      if (filesResponse.ok) {
        this.files = await filesResponse.json();
      } else {
        console.error('Erreur lors de la récupération des fichiers');
      }
    } catch (error) {
      console.error('Erreur lors de la requête:', error);
    }
  },
  methods: {
    formatFileSize(size) {
      const kb = size / 1024;
      const mb = kb / 1024;
      return mb > 1 ? `${mb.toFixed(2)} MB` : `${kb.toFixed(2)} KB`;
    },
    formatDate(dateString) {
      const date = new Date(dateString);
      return date.toLocaleDateString();
    },
    async downloadFile(fileId) {
      try {
        const response = await fetch(`http://localhost:3000/api/files/${fileId}`, {
          headers: {
            Authorization: `Bearer ${localStorage.getItem('token')}`,
          },
        });
        if (!response.ok) {
          throw new Error('Erreur lors du téléchargement du fichier');
        }

        const blob = await response.blob();
        const url = window.URL.createObjectURL(blob);
        const a = document.createElement('a');
        a.href = url;
        a.download = fileId;
        document.body.appendChild(a);
        a.click();
        a.remove();
        window.URL.revokeObjectURL(url);
      } catch (error) {
        console.error('Erreur de téléchargement:', error);
      }
    },
    async deleteFile(fileId) {
      if (!confirm("Voulez-vous vraiment supprimer ce fichier ?")) return;

      try {
        const response = await fetch(`http://localhost:3000/api/files/${fileId}`, {
          method: 'DELETE',
          headers: {
            Authorization: `Bearer ${localStorage.getItem('token')}`,
          },
        });
        if (!response.ok) {
          throw new Error('Erreur lors de la suppression du fichier');
        }

        this.files = this.files.filter(file => file.id !== fileId);

        const quotaResponse = await fetch('http://localhost:3000/api/files/quota', {
          headers: {
            Authorization: `Bearer ${localStorage.getItem('token')}`,
          },
        });
        if (quotaResponse.ok) {
          const quotaData = await quotaResponse.json();
          this.quotaUsed = quotaData.quotaUsed;
        }
      } catch (error) {
        console.error('Erreur de suppression:', error);
      }
    },
    async generateShareLink(fileId) {
      try {
        const response = await fetch(`http://localhost:3000/api/files/share/${fileId}`, {
          method: 'POST',
          headers: {
            Authorization: `Bearer ${localStorage.getItem('token')}`,
          },
        });
        if (!response.ok) {
          throw new Error('Erreur lors de la génération du lien de partage');
        }

        const data = await response.json();
        const shareLink = data.link;

        alert(`Lien de partage généré : ${shareLink}`);
      } catch (error) {
        console.error('Erreur de génération de lien de partage:', error);
      }
    },
  },
};
</script>

<style scoped>
.quota, .files-list {
  margin-top: 1rem;
  padding: 1rem;
  border: 1px solid #ddd;
  border-radius: 8px;
  background-color: #f9f9f9;
}
table {
  width: 100%;
  border-collapse: collapse;
}
th, td {
  padding: 0.5rem;
  border: 1px solid #ddd;
}
button {
  margin-right: 0.5rem;
  padding: 0.25rem 0.5rem;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  background-color: #4f46e5;
  color: white;
}
button:hover {
  background-color: #4338ca;
}
</style>
