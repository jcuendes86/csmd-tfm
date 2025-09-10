import PredictService from './app/services/predictService';
import express, { NextFunction, Request, Response } from 'express';

const app = express();
const port = process.env.PORT || 8080;

// Inicializar la configuración de entorno
console.log('INICIANDO...');

// Middleware de seguridad para validar la cabecera x-from
app.use((req: Request, res: Response, next: NextFunction) => {
    const fromHeader = req.headers['x-from'];
    const expectedHeader = process.env.TOKEN_HEADER_XFROM;

    if (!fromHeader || fromHeader !== expectedHeader) {
        console.log('RES -- ', res.statusMessage);
        return res.status(401).json({
            error: 'Unauthorized',
            message: 'Permiso denegado.'
        });
    }

    next();
});

app.get('/', (req: Request, res: Response) => {
    const message = 'Its OK!';
    
    res.send(message);
});

app.post('/predict', express.json(), (req: Request, res: Response) => {
    // Aquí manejarías la lógica de predicción usando los datos del coche enviados en el cuerpo de la solicitud.
    const carData = req.body; // Asegúrate de validar y tipar esto adecuadamente.
    console.log('Datos recibidos para predicción:', carData);
    const predictService = new PredictService();
    predictService.handler(req, res);
});

app.listen(port, () => {
    console.log(`🚀 Servidor escuchando en el puerto ${port}`);
});
