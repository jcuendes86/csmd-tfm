/** Import main dependencies */
import { BigQueryTool } from '../tools';
import ActiveService from '../tools/ActiveService';
import { CarData, ObjectType } from '../types';

class PredictService {

  // eslint-disable-next-line class-methods-use-this
  async handler(request: ObjectType, reply: ObjectType): Promise<void> {
    // TODO hacer aqui la prediccion
    BigQueryTool.init(ActiveService.getProjectId());

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

    const carData: CarData = request.body;

    try {
        const modelName = ActiveService.getProjectId().concat('.').concat(ActiveService.getBqDatasetName()).concat('.').concat(ActiveService.getBqModelName());
        console.log('Using model name:', modelName);
        const prediction = await BigQueryTool.getPrediction(modelName || '', carData);
        reply.statusCode = 200;
        reply.send({
          status: 200,
          message: 'Predicción realizada con éxito.',
          prediction,
        });
    } catch (error) {
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
  private validateCarData(data: any): string[] {
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
}

export default PredictService;
