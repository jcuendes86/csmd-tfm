SELECT
  predicted_log_price,
  EXP(predicted_log_price) AS predicted_price
FROM
  ML.PREDICT(MODEL `csmd-tfm-jcuendes.cars_sales_dataset.cars_prediction_model`,
    (
      SELECT
        'BMW' AS make,
        'SERIE 6' AS model,
        'GASOLINA' AS fuel,
        2018 AS year,
        150000 AS kms,
        320 AS power,
        2 AS doors,
        'AUTOMATICO' AS shift,
        'NEGRO' AS color,
        'MADRID' AS province,
        'SPAIN' AS country
    )
  );