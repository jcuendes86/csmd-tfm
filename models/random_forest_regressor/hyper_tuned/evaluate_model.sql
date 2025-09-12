SELECT
  *
FROM
  ML.EVALUATE(MODEL `csmd-tfm-jcuendes-pruebas.cars_sales_dataset.cars_price_rfr_model_hyper_tuned`)
ORDER BY r2_score DESC;