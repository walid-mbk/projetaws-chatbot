# Use an official Python runtime as a parent image
FROM python:3.8-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Set work directory
WORKDIR /app

# Install dependencies
COPY requirements/base.txt /app/
COPY requirements/local.txt /app/
COPY requirements/production.txt /app/
COPY sm_core-0.2-py3-none-any.whl /app/

RUN pip install --upgrade ./sm_core-0.2-py3-none-any.whl
RUN pip install --no-cache-dir -r base.txt
RUN pip install --no-cache-dir -r local.txt



RUN pip install --no-cache-dir -r production.txt

# Copy project
COPY . /app/
# Définissez la variable d'environnement USE_DOCKER par défaut à "no"
ENV USE_DOCKER no

# Collecte des fichiers statiques (sans configurer la base de données)
RUN python manage.py collectstatic --noinput

# Run the application
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "your_project_name.wsgi:application"]



