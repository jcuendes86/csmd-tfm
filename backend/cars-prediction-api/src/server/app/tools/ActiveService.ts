import {
  SERVER_HOST,
  SERVER_PORT,
  TOKEN_HEADER_XFROM,
  GOOGLE_CLOUD_PROJECT,
  BQ_DATASET_NAME,
  BQ_ML_MODEL_NAME,
} from '../../config/staticEnvs';

class ActiveService {

  static getServerHost(): string {
    return SERVER_HOST as string;
  }

  static getServerPort(): number {
    return SERVER_PORT as number;
  }

  static getProjectId(): string {
    return GOOGLE_CLOUD_PROJECT as string;
  }

  static getTokenHeaderXFrom(): string {
    return TOKEN_HEADER_XFROM as string;
  }

  static getBqDatasetName(): string {
    return BQ_DATASET_NAME as string;
  }

  static getBqModelName(): string {
    return BQ_ML_MODEL_NAME as string;
  }
}

export default ActiveService;
