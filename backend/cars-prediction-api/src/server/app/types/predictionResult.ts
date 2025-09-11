/**
 * Interfaz para el resultado de la predicción de BigQuery.
 */
interface PredictionResult {
    /**
     * @property {number} predicted_log_price - El logaritmo del precio.
     */
    predicted_log_price: number;
    /**
     * @property {number} predicted_price - El precio.
     */
    predicted_price: number;
}

export default PredictionResult;