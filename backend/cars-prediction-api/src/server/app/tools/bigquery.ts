/**
 * Wrapper BigQuery Tool
 * @description Wrapper class for define all bussines logic for BigQuery tool.
 */

/** Import main dependences */
import { BigQuery } from '@google-cloud/bigquery';
import { CarData, PredictionResult } from '../types';

class BigQueryTool {
  client: BigQuery;

  constructor() {
    this.client = new BigQuery();
  }

  // Init BigQuery.
  init(projectId: string) {
    this.client = new BigQuery({ projectId });
  }

  /**
     * Ejecuta una consulta de predicción en BigQuery ML.
     * @param modelName El nombre completo del modelo de BQ a utilizar.
     * @param carData Los datos del coche para la predicción.
     * @returns Una promesa que se resuelve con el resultado de la predicción.
     */
    public async getPrediction(modelName: string, carData: CarData): Promise<PredictionResult | null> {
        const query = `
            SELECT
              predicted_log_price,
              EXP(predicted_log_price) AS predicted_price
            FROM
              ML.PREDICT(MODEL \`${modelName}\`,
                (
                  SELECT
                    @make AS make, @model AS model, @fuel AS fuel, @year AS year,
                    @kms AS kms, @power AS power, @doors AS doors, @shift AS shift,
                    @color AS color, @province AS province, @country AS country
                )
              )`;

        const options = {
            query: query,
            params: carData, // Uso de parámetros para prevenir inyección SQL
        };

        try {
            console.log(`Ejecutando predicción con el modelo: ${modelName}`);
            const [job] = await this.client.createQueryJob(options);
            const [rows] = await job.getQueryResults();

            if (rows.length > 0) {
                console.log('Predicción obtenida:', rows[0]);
                return rows[0] as PredictionResult;
            } else {
                return null;
            }
        } catch (error) {
            console.error('Error al ejecutar la consulta en BigQuery:', error);
            throw new Error('Error durante la ejecución de la consulta de predicción.');
        }
    }
}

export default new BigQueryTool();
