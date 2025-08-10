# Base recomendada por Google para Flex Templates en Python.
FROM gcr.io/dataflow-templates-base/python312-template-launcher-base:latest

# Directorio de trabajo dentro de la imagen
ARG WORKDIR=/dataflow/template
WORKDIR ${WORKDIR}

# Copia e instala dependencias (debe existir requirements.txt junto al .py)
COPY requirements.txt ${WORKDIR}/requirements.txt
RUN pip install --no-cache-dir -r ${WORKDIR}/requirements.txt

# Copia el código del pipeline
COPY cars_dataset_pipeline.py ${WORKDIR}/cars_dataset_pipeline.py

# Variables que el launcher de Flex Template usa para ejecutar tu pipeline
ENV FLEX_TEMPLATE_PYTHON_PY_FILE="${WORKDIR}/cars_dataset_pipeline.py" \
    FLEX_TEMPLATE_PYTHON_REQUIREMENTS_FILE="${WORKDIR}/requirements.txt"

# Launcher incluido en la base image
ENTRYPOINT ["/opt/google/dataflow/python_template_launcher"]