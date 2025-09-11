/**
 * @interface ObjectType
 * @description Interfaz que define un tipo de objeto genérico que permite cualquier propiedad.
 */
export default interface ObjectType {
  /**
   * @property {[key: string]: any}
   * @description Permite cualquier propiedad con clave de tipo string.
   */
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  [key: string]: any;
}