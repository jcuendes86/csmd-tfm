SELECT
  predicted_log_price,
  EXP(predicted_log_price) AS predicted_price
FROM
  ML.PREDICT(MODEL `csmd-tfm-jcuendes.cars_sales_dataset.cars_prediction_model`,
    (
      SELECT
        'KIA' AS make,
        'SPORTAGE' AS model,
        'GASOLINA' AS fuel,
        2020 AS year,
        50000 AS kms,
        140 AS power,
        5 AS doors,
        'AUTOMATICO' AS shift,
        'GRIS' AS color,
        'SEVILLA' AS province,
        'SPAIN' AS country
    )
  );