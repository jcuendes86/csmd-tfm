/** Importar dependencias */
import { BigQuery } from '@google-cloud/bigquery';
import { CarData, PredictionResult } from '../types';

/**
 * @class BigQueryTool
 * @description Clase que encapsula la lógica de negocio para interactuar con BigQuery.
 */
class BigQueryTool {
  /**
   * @property {BigQuery} client - Cliente de BigQuery.
   */
  client: BigQuery;

  /**
   * @constructor
   */
  constructor() {
    this.client = new BigQuery();
  }

  /**
   * @method init
   * @description Inicializa el cliente de BigQuery con un ID de proyecto.
   * @param {string} projectId - ID del proyecto de Google Cloud.
   */
  init(projectId: string) {
    this.client = new BigQuery({ projectId });
  }

  /**
     * @method getPrediction
     * @description Ejecuta una consulta de predicción en BigQuery ML.
     * @param {string} modelName - El nombre completo del modelo de BQ a utilizar.
     * @param {CarData} carData - Los datos del coche para la predicción.
     * @returns {Promise<PredictionResult | null>} Una promesa que se resuelve con el resultado de la predicción.
     */
    public async getPrediction(modelName: string, carData: CarData): Promise<PredictionResult | null> {
        // Construir la consulta de predicción
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

        // Opciones de la consulta, incluyendo los parámetros para prevenir inyección SQL
        const options = {
            query: query,
            params: carData,
        };

        try {
            // Crear y ejecutar el trabajo de consulta
            const [job] = await this.client.createQueryJob(options);
            const [rows] = await job.getQueryResults();

            // Si hay resultados, devolver el primero
            if (rows.length > 0) {
                return rows[0] as PredictionResult;
            }
            
            return null;
        } catch (error) {
            // Manejo de errores
            console.error('Error al ejecutar la consulta en BigQuery:', error);
            throw new Error('Error durante la ejecución de la consulta de predicción.');
        }
    }
}

// Exportar una instancia única de la herramienta
export default new BigQueryTool();