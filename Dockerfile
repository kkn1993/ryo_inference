
FROM python:3.10-slim-bookworm
# ARG PYVERSION=py310
# FROM baseten/truss-server-base:3.10-v0.4.9 as truss_server

# ENV PYTHON_EXECUTABLE python3


# RUN grep -w 'ID=debian\|ID_LIKE=debian' /etc/os-release || { echo "ERROR: Supplied base image is not a debian image"; exit 1; }
# RUN $PYTHON_EXECUTABLE -c "import sys; sys.exit(0) if sys.version_info.major == 3 and sys.version_info.minor >=8 and sys.version_info.minor <=11 else sys.exit(1)" \
#     || { echo "ERROR: Supplied base image does not have 3.8 <= python <= 3.11"; exit 1; }


RUN pip install --upgrade pip --no-cache-dir \
    && rm -rf /root/.cache/pip


# If user base image is supplied in config, apply build commands from truss base image















COPY ./requirements.txt requirements.txt
RUN pip install -r requirements.txt --no-cache-dir && rm -rf /root/.cache/pip






ENV APP_HOME /app
WORKDIR $APP_HOME



# Copy data before code for better caching
# COPY ./data /app/data

COPY ./src/server /app/server
COPY ./src/inference /app/inference
COPY ./config.yaml /app/config.yaml






# COPY ./packages /packages






ENV INFERENCE_SERVER_PORT 8080
ENV SERVER_START_CMD="python3 /app/server/inference_server.py"
ENTRYPOINT ["python3", "/app/server/inference_server.py"]
