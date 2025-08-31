import path from 'node:path';
import dotenv from 'dotenv';
import { ObjectType } from '../types';

class Environment {

  init = async (pathName: string): Promise<void> => new Promise((resolve) => {
    // Init arguments object
    let args: ObjectType = {};
    // Get all Arguments of Params and iterate for create object
    process.argv.slice(2).forEach((x) => {
      const data = x.split('=');
      if (Array.isArray(data) && data.length > 0) {
        args = Object.assign(args, { [data[0]]: data[1] });
      }
    });
    // Set default env file
    const pathEnv = path.resolve(pathName);

    // Set __mocks__ dotenv by file.
    dotenv.config({
      path: pathEnv,
    });
    resolve();
  });

  setVar = (name: string, value: string): void => {
    process.env[name] = value;
  };

  getVar(name: string): string | null {
    return process.env[name] ?? null;
  }

  getBoolean(name: string): boolean {
    const value = this.getVar(name);
    if (!value) {
      return false;
    }

    return value.toLowerCase() === 'true';
  }

  getNumber(name: string): number | null {
    const value = this.getVar(name);

    if (!value) {
      return null;
    }

    const number = Number(value);
    if (Number.isNaN(number)) {
      return null;
    }

    return number;
  }
}

export default new Environment();
