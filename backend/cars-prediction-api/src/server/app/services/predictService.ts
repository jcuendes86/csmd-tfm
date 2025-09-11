/** Importar dependencias */
import { BigQueryTool } from '../tools';
import ActiveService from '../tools/ActiveService';
import { CarData, ObjectType } from '../types';

/**
 * @class PredictService
 * @description Clase para manejar la lógica de negocio del servicio de predicción.
 */
class PredictService {
  /**
   * @method handler
   * @description Manejador de la solicitud de predicción.
   * @param {ObjectType} request - Objeto de la solicitud.
   * @param {ObjectType} reply - Objeto de la respuesta.
   * @returns {Promise<void>}
   */
  async handler(request: ObjectType, reply: ObjectType): Promise<void> {
    // Inicializar BigQuery con el ID del proyecto
    BigQueryTool.init(ActiveService.getProjectId());

    // Validar los datos de entrada
    const validationErrors = this.validateCarData(request.body);
    if (validationErrors.length > 0) {
        reply.statusCode = 200;
        reply.send({
          status: 400,
          error: 'Datos de entrada inválidos.',
          message: validationErrors,
        });
        return;
    }

    // Normalizar los datos del coche
    const carData: CarData = this.normalizeCarData(request.body);

    try {
        // Construir el nombre completo del modelo de BigQuery
        const modelName = ActiveService.getProjectId().concat('.').concat(ActiveService.getBqDatasetName()).concat('.').concat(ActiveService.getBqModelName());
        console.log('Datos recibidos para predicción: ', JSON.stringify(carData));
        // Obtener la predicción desde BigQuery
        const prediction = await BigQueryTool.getPrediction(modelName || '', carData);
        console.log('Predicción obtenida: ', JSON.stringify(prediction));
        // Enviar la respuesta con la predicción
        reply.statusCode = 200;
        reply.send({
          status: 200,
          message: 'Predicción realizada con éxito.',
          prediction,
        });
    } catch (error) {
        // Manejar errores durante la predicción
        console.error('Error en el controlador de predicción:', error);
        reply.statusCode = 500;
        reply.send({
          status: 500,
          error: 'Ha ocurrido un error al procesar la predicción.',
          message: error,
        });
        return;
    }
  }

  /**
   * Valida que los datos de entrada tengan el formato correcto.
   * @param data - El cuerpo de la solicitud a validar.
   * @returns Un array con los mensajes de error. Vacío si no hay errores.
   */
  private validateCarData(data: ObjectType): string[] {
      const requiredFields: (keyof CarData)[] = [
          'make', 'model', 'fuel', 'year', 'kms', 'power', 'doors', 
          'shift', 'color', 'province', 'country'
      ];
      const errors: string[] = [];

      for (const field of requiredFields) {
          if (data[field] === undefined || data[field] === null) {
              errors.push(`El campo '${field}' es obligatorio.`);
          }
      }

      if (errors.length > 0) return errors;

      if (typeof data.year !== 'number') errors.push('El campo \'year\' debe ser numérico.');
      if (typeof data.kms !== 'number') errors.push('El campo \'kms\' debe ser numérico.');
      if (typeof data.power !== 'number') errors.push('El campo \'power\' debe ser numérico.');
      if (typeof data.doors !== 'number') errors.push('El campo \'doors\' debe ser numérico.');
      
      return errors;
  }

  /**
   * Normaliza y convierte a mayúsculas los campos de tipo string de CarData.
   * @param data - El objeto CarData a normalizar.
   * @returns Un nuevo objeto CarData con los datos normalizados.
   */
  private normalizeCarData(data: CarData): CarData {
    const newData = { ...data };
    for (const key in newData) {
      if (Object.prototype.hasOwnProperty.call(newData, key)) {
        const typedKey = key as keyof CarData;
        if (typeof newData[typedKey] === 'string') {
          const value = newData[typedKey] as string;
          const normalizedValue = value
            .normalize('NFD')
            .replace(/[̀-ͤ]/g, '');
          (newData as any)[typedKey] = normalizedValue.toUpperCase();
        }
      }
    }
    return newData;
  }
}

export default PredictService;