import dotenv from 'dotenv';
import path from 'path';
import fs from 'fs';
import { Environment } from '../app/tools';

class EnvConfig {

    init() {
        // Ruta donde Cloud Run monta el secreto.
        // Terraform 'volume_mounts.mount_path' -> /cars-prediction-api/env
        // Terraform 'volumes.secret.items.path' -> .env
        const cloudRunSecretPath = path.resolve('/cars-prediction-api/env/.env');

        console.log(`Intentando cargar variables de entorno desde: ${cloudRunSecretPath}`);

        // Ruta para el desarrollo local (un archivo .env en la raíz del proyecto).
        const localEnvPath = path.resolve(process.cwd(), './env/.env');

        console.log(`Ruta local para desarrollo: ${localEnvPath}`);

        // Determinar qué ruta usar.
        // Si estamos en Cloud Run, el archivo montado existirá.
        const envPath = fs.existsSync(cloudRunSecretPath) ? cloudRunSecretPath : localEnvPath;

        console.log(`Cargando variables de entorno desde: ${envPath}`);

        // Cargar las variables de entorno desde el archivo correspondiente.
        const result = dotenv.config({ path: envPath });

        console.log(`Resultado de la carga de .env: ${JSON.stringify(result)}`);

        if (result.error) {
            // En producción (Cloud Run), es crítico que el secreto se cargue.
            // Si la ruta del secreto existe pero falla la carga, es un error fatal.
            if (envPath === cloudRunSecretPath) {
                console.error('Error crítico: no se pudieron cargar las variables de entorno desde el secreto montado.');
                throw result.error;
            }
            // En desarrollo, es normal no tener un .env, así que solo mostramos una advertencia.
            console.warn(`No se encontró o no se pudo cargar el archivo .env en: ${envPath}`);
        }

        console.log('✅ Configuración cargada correctamente.');
    }
}

export default new EnvConfig();



// Opcional: Validar y exportar variables de entorno tipadas.
// Esto previene errores en tiempo de ejecución si una variable no está definida.

// const getEnvVar = (key: string): string => {
//     const value = process.env[key];
//     if (!value) {
//         throw new Error(`La variable de entorno ${key} no está definida.`);
//     }
//     return value;
// };

// export const config = {
//     // Ejemplo: Suponiendo que tu secreto tiene una clave llamada API_KEY
//     apiKey: getEnvVar('API_KEY'),
    
//     // Ejemplo: Suponiendo que tu secreto tiene una clave para la base de datos
//     databaseUrl: getEnvVar('DATABASE_URL'),

//     // Puedes añadir más variables aquí
//     nodeEnv: process.env.NODE_ENV || 'development'
// };
