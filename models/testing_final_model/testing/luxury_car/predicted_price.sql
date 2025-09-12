SELECT
  predicted_log_price,
  EXP(predicted_log_price) AS predicted_price
FROM
  ML.PREDICT(MODEL `csmd-tfm-jcuendes.cars_sales_dataset.cars_prediction_model`,
    (
      SELECT
        'FERRARI' AS make,
        '811' AS model,
        'GASOLINA' AS fuel,
        2023 AS year,
        10000 AS kms,
        800 AS power,
        3 AS doors,
        'AUTOMATICO' AS shift,
        'ROJO' AS color,
        'SEVILLA' AS province,
        'SPAIN' AS country
    )
  );