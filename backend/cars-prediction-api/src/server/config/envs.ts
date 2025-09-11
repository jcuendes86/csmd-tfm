/**
 * Este fichero se encarga de cargar las variables de entorno desde un archivo .env,
 * ya sea en un entorno de desarrollo local o en Cloud Run.
 */
import dotenv from 'dotenv';
import path from 'path';
import fs from 'fs';

/**
 * @class EnvConfig
 * @description Clase para inicializar la configuración de las variables de entorno.
 */
class EnvConfig {
    /**
     * @method init
     * @description Inicializa la configuración de las variables de entorno.
     * Busca el fichero .env en la ruta de Cloud Run o en la ruta local.
     */
    init() {
        // Ruta donde Cloud Run monta el secreto.
        const cloudRunSecretPath = path.resolve('/cars-prediction-api/env/.env');

        // Ruta para el desarrollo local (un archivo .env en la raíz del proyecto).
        const localEnvPath = path.resolve(process.cwd(), './env/.env');
        // Determinar qué ruta usar.
        // Si estamos en Cloud Run, el archivo montado existirá.
        const envPath = fs.existsSync(cloudRunSecretPath) ? cloudRunSecretPath : localEnvPath;

        // Cargar las variables de entorno desde el archivo correspondiente.
        const result = dotenv.config({ path: envPath });

        if (result.error) {
            if (envPath === cloudRunSecretPath) {
                console.error('Error crítico: no se pudieron cargar las variables de entorno desde el secreto montado.');
                throw result.error;
            }
            console.warn(`No se encontró o no se pudo cargar el archivo .env en: ${envPath}`);
        }

        console.log('✅ Configuración cargada correctamente.');
    }
}

export default new EnvConfig();