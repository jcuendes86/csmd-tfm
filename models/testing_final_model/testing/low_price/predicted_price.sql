SELECT
  predicted_log_price,
  EXP(predicted_log_price) AS predicted_price
FROM
  ML.PREDICT(MODEL `csmd-tfm-jcuendes.cars_sales_dataset.cars_prediction_model`,
    (
      SELECT
        'AUDI' AS make,
        'A4' AS model,
        'GASOLINA' AS fuel,
        2000 AS year,
        230000 AS kms,
        220 AS power,
        5 AS doors,
        'MANUAL' AS shift,
        'BLANCO' AS color,
        'SANTANDER' AS province,
        'SPAIN' AS country
    )
  );