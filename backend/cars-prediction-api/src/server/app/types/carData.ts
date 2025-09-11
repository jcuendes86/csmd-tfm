/**
 * Interfaz que define la estructura de datos esperada para un coche. 
 * Se utiliza para el tipado y la validación de los datos de entrada.
 */
interface CarData {
    /**
     * @property {string} make - Marca del coche.
     */
    make: string;
    /**
     * @property {string} model - Modelo del coche.
     */
    model: string;
    /**
     * @property {string} fuel - Tipo de combustible.
     */
    fuel: string;
    /**
     * @property {number} year - Año de fabricación.
     */
    year: number;
    /**
     * @property {number} kms - Kilómetros recorridos.
     */
    kms: number;
    /**
     * @property {number} power - Potencia del motor en CV.
     */
    power: number;
    /**
     * @property {number} doors - Número de puertas.
     */
    doors: number;
    /**
     * @property {string} shift - Tipo de transmisión (manual o automática).
     */
    shift: string;
    /**
     * @property {string} color - Color del coche.
     */
    color: string;
    /**
     * @property {string} province - Provincia.
     */
    province: string;
    /**
     * @property {string} country - País.
     */
    country: string;
}

export default CarData;