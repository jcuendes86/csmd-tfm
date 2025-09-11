/**
 * Punto de entrada del servidor. Inicializa el servidor Express, configura los middlewares y las rutas.
 */
import PredictService from './app/services/predictService';
import express, { NextFunction, Request, Response } from 'express';

// Crear una instancia de la aplicación Express
const app = express();
// Obtener el puerto de las variables de entorno o usar 8080 por defecto
const port = process.env.PORT || 8080;

// Inicializar la configuración de entorno
console.log('⏳ Iniciando servidor...');

/**
 * Middleware de seguridad que valida la cabecera x-from en cada solicitud.
 */
app.use((req: Request, res: Response, next: NextFunction) => {
    const fromHeader = req.headers['x-from'];
    const expectedHeader = process.env.TOKEN_HEADER_XFROM;

    // Si la cabecera no existe o no es la esperada, denegar el acceso
    if (!fromHeader || fromHeader !== expectedHeader) {
        console.log('RES -- ', res.statusMessage);
        return res.status(401).json({
            error: 'Unauthorized',
            message: 'Permiso denegado.'
        });
    }

    // Si la cabecera es válida, continuar con la siguiente función de middleware
    next();
});

/**
 * Ruta para comprobar el estado del servidor.
 */
app.get('/', (req: Request, res: Response) => {
    const message = 'Its OK!';
    
    res.send(message);
});

/**
 * Ruta para realizar una predicción del precio de un coche.
 */
app.post('/predict', express.json(), (req: Request, res: Response) => {
    // Se utiliza el servicio de predicción para manejar la lógica de la solicitud.
    const predictService = new PredictService();
    predictService.handler(req, res);
});

// Iniciar el servidor y escuchar en el puerto especificado
app.listen(port, () => {
    console.log(`🚀 Servidor escuchando en el puerto ${port}`);
});