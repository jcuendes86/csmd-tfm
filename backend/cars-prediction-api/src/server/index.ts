import EnvConfig from './config/envs';
import PredictService from './app/services/predictService';
import express from 'express';

const app = express();
const port = process.env.PORT || 8080;

// Inicializar la configuración de entorno
console.log('INICIANDO...');

app.get('/', (req, res) => {
    console.log('Endpoint invocado. Usando variables de entorno...');

    // Usa las variables de entorno cargadas a través del objeto 'config'
    const message = 'Hola desde la API de predicción de coches en Cloud Run.';
    // const message = `
    //     ¡Hola desde la API en Cloud Run!
    //     La API Key es: ${config.apiKey ? 'Cargada correctamente (oculta por seguridad)' : 'No cargada'}
    //     La URL de la BBDD es: ${config.databaseUrl}
    //     Entorno (NODE_ENV): ${config.nodeEnv}
    // `;
    
    res.send(message);
});

app.post('/predict', express.json(), (req, res) => {
    // Aquí manejarías la lógica de predicción usando los datos del coche enviados en el cuerpo de la solicitud.
    const carData = req.body; // Asegúrate de validar y tipar esto adecuadamente.
    console.log('Datos recibidos para predicción:', carData);
    const predictService = new PredictService();
    predictService.handler(req, res);
});

app.listen(port, () => {
    console.log(`🚀 Servidor escuchando en el puerto ${port}`);
});
