SELECT
  predicted_log_price,
  EXP(predicted_log_price) AS predicted_price
FROM
  ML.PREDICT(MODEL `csmd-tfm-jcuendes.cars_sales_dataset.cars_prediction_model`,
    (
      SELECT
        'VOLKSWAGEN' AS make,
        'GOLF' AS model,
        'DIESEL' AS fuel,
        2020 AS year,
        15000 AS kms,
        120 AS power,
        5 AS doors,
        'MANUAL' AS shift,
        'NEGRO' AS color,
        'SANTANDER' AS province,
        'SPAIN' AS country
    )
  );