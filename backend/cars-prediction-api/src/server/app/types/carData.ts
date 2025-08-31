/**
 * Interfaz que define la estructura de datos esperada para un coche.
 * Se utiliza para el tipado y la validación de los datos de entrada.
 */
interface CarData {
    make: string;
    model: string;
    fuel: string;
    year: number;
    kms: number;
    power: number;
    doors: number;
    shift: string;
    color: string;
    province: string;
    country: string;
}

export default CarData;
