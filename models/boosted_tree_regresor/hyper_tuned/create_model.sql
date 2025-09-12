CREATE OR REPLACE MODEL `csmd-tfm-jcuendes-pruebas.cars_sales_dataset.cars_price_btr_model_hyper_tuned`
OPTIONS(
  MODEL_TYPE='BOOSTED_TREE_REGRESSOR',
  INPUT_LABEL_COLS=['log_price'],

  -- Objetivo de tuning
  NUM_TRIALS=25,
  MAX_PARALLEL_TRIALS=3,
  HPARAM_TUNING_OBJECTIVES=['R2_SCORE'],

  -- Espacio de búsqueda
  LEARN_RATE=HPARAM_RANGE(0.02, 0.20),
  MAX_TREE_DEPTH=HPARAM_CANDIDATES([4,6,8,10,12]),
  L1_REG=HPARAM_RANGE(0.0, 0.5),
  L2_REG=HPARAM_RANGE(0.5, 5.0),

  -- Entrenamiento / split
  EARLY_STOP=TRUE,
  MAX_ITERATIONS=600
) AS
SELECT
  make, model, fuel, year, kms, power, doors, shift,
  color, province, country, LOG(price) as log_price
FROM `csmd-tfm-jcuendes-pruebas.cars_sales_dataset.cars_sales`
WHERE price IS NOT NULL;