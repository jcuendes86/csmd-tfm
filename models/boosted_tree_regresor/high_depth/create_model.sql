CREATE OR REPLACE MODEL `csmd-tfm-jcuendes-pruebas.cars_sales_dataset.cars_price_btr_model_high_depth`
OPTIONS(
  model_type='BOOSTED_TREE_REGRESSOR',
  input_label_cols=['price'],
  -- Ajustes para un modelo más complejo
  LEARN_RATE=0.3, -- Tasa de aprendizaje por defecto
  MAX_TREE_DEPTH=15, -- Permite aprender patrones más detallados
  L2_REG=0.25, -- Añade regularización para evitar el sobreajuste
  EARLY_STOP=TRUE, -- Detiene el entrenamiento si el modelo ya no mejora
  MAX_ITERATIONS=100 -- Número máximo de iteraciones (árboles)
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