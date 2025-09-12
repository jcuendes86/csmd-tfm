CREATE OR REPLACE MODEL `csmd-tfm-jcuendes.cars_sales_dataset.cars_price_btr_model_accurate`
OPTIONS(
  model_type='BOOSTED_TREE_REGRESSOR',
  input_label_cols=['price'],
  -- Ajustes para un modelo más complejo
  MAX_TREE_DEPTH=10, -- Permite aprender patrones más detallados
  L2_REG=0.1, -- Añade regularización para evitar el sobreajuste
  EARLY_STOP=TRUE -- Detiene el entrenamiento si el modelo ya no mejora
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
  `csmd-tfm-jcuendes.cars_sales_dataset.cars_sales`
WHERE
  price IS NOT NULL; -- Asegurar que el precio no sea nulo