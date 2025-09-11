/** Importar dependencias */
import {
  SERVER_HOST,
  SERVER_PORT,
  TOKEN_HEADER_XFROM,
  GOOGLE_CLOUD_PROJECT,
  BQ_DATASET_NAME,
  BQ_ML_MODEL_NAME,
} from '../../config/staticEnvs';

/**
 * @class ActiveService
 * @description Clase para gestionar las variables de entorno y configuraciones del servicio
 */
class ActiveService {

  /**
   * @method getServerHost
   * @description Obtiene el host del servidor
   * @returns {string}
   */
  static getServerHost(): string {
    return SERVER_HOST as string;
  }

  /**
   * @method getServerPort
   * @description Obtiene el puerto del servidor
   * @returns {number}
   */
  static getServerPort(): number {
    return SERVER_PORT as number;
  }

  /**
   * @method getProjectId
   * @description Obtiene el ID del proyecto de Google Cloud
   * @returns {string}
   */
  static getProjectId(): string {
    return GOOGLE_CLOUD_PROJECT as string;
  }

  /**
   * @method getTokenHeaderXFrom
   * @description Obtiene el valor del header para la autenticación
   * @returns {string}
   */
  static getTokenHeaderXFrom(): string {
    return TOKEN_HEADER_XFROM as string;
  }

  /**
   * @method getBqDatasetName
   * @description Obtiene el nombre del dataset de BigQuery
   * @returns {string}
   */
  static getBqDatasetName(): string {
    return BQ_DATASET_NAME as string;
  }

  /**
   * @method getBqModelName
   * @description Obtiene el nombre del modelo de BigQuery
   * @returns {string}
   */
  static getBqModelName(): string {
    return BQ_ML_MODEL_NAME as string;
  }
}

export default ActiveService;