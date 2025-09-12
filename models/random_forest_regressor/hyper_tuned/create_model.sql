CREATE OR REPLACE MODEL `csmd-tfm-jcuendes-pruebas.cars_sales_dataset.cars_price_rfr_model_hyper_tuned`
OPTIONS(
  MODEL_TYPE='RANDOM_FOREST_REGRESSOR',
  INPUT_LABEL_COLS=['log_price'],

  -- Objetivo de tuning
  NUM_TRIALS=25,
  MAX_PARALLEL_TRIALS=3,
  HPARAM_TUNING_OBJECTIVES=['R2_SCORE'],

  -- Capacidad del bosque / complejidad de cada árbol
  NUM_PARALLEL_TREE=HPARAM_RANGE(100, 600),
  MAX_TREE_DEPTH=HPARAM_CANDIDATES([8,10,12,15,20]),

  -- Splits más estrictos
  MIN_TREE_CHILD_WEIGHT=HPARAM_RANGE(1, 20),     -- evita hojas con muy pocos ejemplos
  MIN_SPLIT_LOSS=HPARAM_RANGE(0.0, 2.0)         -- (gamma) mejora mínima de pérdida
) AS
SELECT
  make, model, fuel, year, kms, power, doors, shift,
  color, province, country, LOG(price) as log_price
FROM `csmd-tfm-jcuendes-pruebas.cars_sales_dataset.cars_sales`
WHERE price IS NOT NULL;