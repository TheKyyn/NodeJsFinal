const express = require('express');
const cors = require('cors');
const dotenv = require('dotenv');
const authRoutes = require('./routes/authRoutes');
const fileRoutes = require('./routes/fileRoutes');
const authenticate = require('./middleware/authMiddleware');

dotenv.config();

const app = express();
const PORT = process.env.PORT || 3000;

const allowedOrigins = ['http://localhost:8081', 'http://localhost:8080'];
app.use(cors({
    origin: function (origin, callback) {
        if (!origin || allowedOrigins.includes(origin)) {
            callback(null, true);
        } else {
            callback(new Error('Not allowed by CORS'));
        }
    },
}));

app.use(express.json());
app.use('/api/auth', authRoutes);
app.use('/api/files', authenticate, fileRoutes);

app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});
