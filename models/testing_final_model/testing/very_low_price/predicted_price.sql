SELECT
  predicted_log_price,
  EXP(predicted_log_price) AS predicted_price
FROM
  ML.PREDICT(MODEL `csmd-tfm-jcuendes.cars_sales_dataset.cars_prediction_model`,
    (
      SELECT
        'DAEWOO' AS make,
        'KALOS' AS model,
        'GASOLINA' AS fuel,
        2003 AS year,
        130500 AS kms,
        72 AS power,
        3 AS doors,
        'MANUAL' AS shift,
        'AZUL' AS color,
        'CADIZ' AS province,
        'SPAIN' AS country
    )
  );