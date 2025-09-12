CREATE OR REPLACE MODEL `csmd-tfm-jcuendes-pruebas.cars_sales_dataset.cars_price_rfr_model_high_depth`
OPTIONS(
  model_type='RANDOM_FOREST_REGRESSOR',
  input_label_cols=['price'],
  -- Hiperparámetros ajustados --
  NUM_PARALLEL_TREE=300,              -- Mas árboles.
  MAX_TREE_DEPTH=20,                  -- Permitimos que los árboles individuales sean bastante profundos.
  MIN_TREE_CHILD_WEIGHT=10            -- Aumentamos el mínimo de muestras para crear una hoja
) AS
SELECT
  -- Seleccionamos todas las columnas que servirán para predecir
  make,
  model,
  fuel,
  year,
  kms,
  power,
  doors,
  shift,
  color,
  province,
  country,
  -- Esta es la variable que queremos predecir
  price
FROM
  `csmd-tfm-jcuendes-pruebas.cars_sales_dataset.cars_sales`
WHERE
  price IS NOT NULL; -- Asegurar que el precio no sea nulo