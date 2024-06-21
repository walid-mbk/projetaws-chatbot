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

# Set PostgreSQL environment variables
ENV POSTGRES_HOST=chatbot_backend
ENV POSTGRES_PORT=5432
ENV POSTGRES_DB=chatbot_backend
ENV POSTGRES_USER=juEkUcuxsDbtfyIaRUMuGPlDQiZQPTqy
ENV POSTGRES_PASSWORD=xdu1mGccnBpNbftNqE8317N3RJftxMw1GEw4s0542wjIxEEx4cxeExeTUmQ8aUC6

# Set DATABASE_URL environment variable
ENV DATABASE_URL postgres://$POSTGRES_USER:$POSTGRES_PASSWORD@$POSTGRES_HOST:$POSTGRES_PORT/$POSTGRES_DB

# Set USE_DOCKER environment variable
ENV USE_DOCKER yes


# Collect static files (without configuring the database)
RUN python manage.py collectstatic --noinput

# Run the application
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
