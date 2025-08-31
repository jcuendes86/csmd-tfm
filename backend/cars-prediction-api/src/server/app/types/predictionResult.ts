/**
 * Interfaz para el resultado de la predicción de BigQuery.
 */
interface PredictionResult {
    predicted_log_price: number;
    predicted_price: number;
}

export default PredictionResult;
