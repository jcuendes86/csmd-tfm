SELECT
  predicted_price
FROM
  ML.PREDICT(MODEL `csmd-tfm-jcuendes-pruebas.cars_sales_dataset.cars_price_rfr_model`,
    (
      SELECT
        'Audi' AS make,
        'A3' AS model,
        'Gasoline' AS fuel,
        2018 AS year,
        80000 AS kms,
        150 AS power,
        5 AS doors,
        'Manual' AS shift,
        'White' AS color,
        'Barcelona' AS province,
        'Spain' AS country
    )
  );