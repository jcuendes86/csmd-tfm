import Environment from '../app/tools/environment';

const SERVER_HOST = Environment.getVar('SERVER_HOST');
const SERVER_PORT = Environment.getNumber('SERVER_PORT');
const TOKEN_HEADER_XFROM = Environment.getVar('TOKEN_HEADER_XFROM');
const GOOGLE_CLOUD_PROJECT = Environment.getVar('GOOGLE_CLOUD_PROJECT');
const BQ_DATASET_NAME = Environment.getVar('BQ_DATASET_NAME');
const BQ_ML_MODEL_NAME = Environment.getVar('BQ_ML_MODEL_NAME');

export {
  SERVER_HOST,
  SERVER_PORT,
  TOKEN_HEADER_XFROM,
  GOOGLE_CLOUD_PROJECT,
  BQ_DATASET_NAME,
  BQ_ML_MODEL_NAME,
};
