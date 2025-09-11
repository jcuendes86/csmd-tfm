/** Importar dependencias */
import path from 'node:path';
import dotenv from 'dotenv';
import { ObjectType } from '../types';

/**
 * @class Environment
 * @description Clase para gestionar las variables de entorno.
 */
class Environment {

  /**
   * @method init
   * @description Inicializa las variables de entorno desde un archivo y los argumentos del proceso.
   * @param {string} pathName - Ruta al archivo .env.
   * @returns {Promise<void>}
   */
  init = async (pathName: string): Promise<void> => new Promise((resolve) => {
    // Inicializar objeto de argumentos
    let args: ObjectType = {};
    // Obtener todos los argumentos del proceso y crear un objeto
    process.argv.slice(2).forEach((x) => {
      const data = x.split('=');
      if (Array.isArray(data) && data.length > 0) {
        args = Object.assign(args, { [data[0]]: data[1] });
      }
    });
    // Establecer la ruta del archivo .env por defecto
    const pathEnv = path.resolve(pathName);

    // Configurar dotenv para cargar las variables de entorno desde el archivo especificado.
    dotenv.config({
      path: pathEnv,
    });
    resolve();
  });

  /**
   * @method setVar
   * @description Establece una variable de entorno.
   * @param {string} name - Nombre de la variable.
   * @param {string} value - Valor de la variable.
   */
  setVar = (name: string, value: string): void => {
    process.env[name] = value;
  };

  /**
   * @method getVar
   * @description Obtiene el valor de una variable de entorno.
   * @param {string} name - Nombre de la variable.
   * @returns {string | null} - Valor de la variable o null si no existe.
   */
  getVar(name: string): string | null {
    return process.env[name] ?? null;
  }

  /**
   * @method getBoolean
   * @description Obtiene el valor booleano de una variable de entorno.
   * @param {string} name - Nombre de la variable.
   * @returns {boolean} - Valor booleano de la variable.
   */
  getBoolean(name: string): boolean {
    const value = this.getVar(name);
    if (!value) {
      return false;
    }

    return value.toLowerCase() === 'true';
  }

  /**
   * @method getNumber
   * @description Obtiene el valor numérico de una variable de entorno.
   * @param {string} name - Nombre de la variable.
   * @returns {number | null} - Valor numérico de la variable o null si no es un número.
   */
  getNumber(name: string): number | null {
    const value = this.getVar(name);

    if (!value) {
      return null;
    }

    const number = Number(value);
    if (Number.isNaN(number)) {
      return null;
    }

    return number;
  }
}

// Exportar una instancia única de la clase
export default new Environment();