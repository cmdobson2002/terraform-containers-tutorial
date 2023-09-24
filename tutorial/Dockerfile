# Specify python version we're using
FROM python:3.9

# Set the working directory in the container to `/code`
# WORKDIR
# Copy over our requirements.txt file into the image at /code/requirements.txt
# COPY
# Install all of our dependencies in requirements.txt using pip: include --no-cache-dir and --upgrade command flags
# RUN
# Copy the app folder into /code/app, similar to requirements.txt
# COPY
# This command is run when container is started: uvicorn starts a server with endpoints specified in app/main.py
CMD ["uvicorn", "app.main:app", "--reload", "--host", "0.0.0.0"]