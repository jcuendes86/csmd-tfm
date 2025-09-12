CREATE OR REPLACE MODEL `csmd-tfm-jcuendes-pruebas.cars_sales_dataset.cars_price_btr_model_low_depth`
OPTIONS(
  model_type='BOOSTED_TREE_REGRESSOR',
  input_label_cols=['price'],
  -- Ajustes para un modelo más rápido y simple
  MAX_TREE_DEPTH=4 -- Árboles menos profundos
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