/**
 * Este fichero exporta las variables de entorno como constantes para ser utilizadas en la aplicación.
 */
import Environment from '../app/tools/environment';

/**
 * @const {string | null} SERVER_HOST - Host del servidor.
 */
const SERVER_HOST = Environment.getVar('SERVER_HOST');

/**
 * @const {number | null} SERVER_PORT - Puerto del servidor.
 */
const SERVER_PORT = Environment.getNumber('SERVER_PORT');

/**
 * @const {string | null} TOKEN_HEADER_XFROM - Nombre del header para el token de autenticación.
 */
const TOKEN_HEADER_XFROM = Environment.getVar('TOKEN_HEADER_XFROM');

/**
 * @const {string | null} GOOGLE_CLOUD_PROJECT - ID del proyecto de Google Cloud.
 */
const GOOGLE_CLOUD_PROJECT = Environment.getVar('GOOGLE_CLOUD_PROJECT');

/**
 * @const {string | null} BQ_DATASET_NAME - Nombre del dataset de BigQuery.
 */
const BQ_DATASET_NAME = Environment.getVar('BQ_DATASET_NAME');

/**
 * @const {string | null} BQ_ML_MODEL_NAME - Nombre del modelo de Machine Learning en BigQuery.
 */
const BQ_ML_MODEL_NAME = Environment.getVar('BQ_ML_MODEL_NAME');

export {
  SERVER_HOST,
  SERVER_PORT,
  TOKEN_HEADER_XFROM,
  GOOGLE_CLOUD_PROJECT,
  BQ_DATASET_NAME,
  BQ_ML_MODEL_NAME,
};