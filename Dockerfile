# Use the official Python image
FROM python:3.8.15-alpine

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Set the working directory
WORKDIR /app

# Install system dependencies
RUN apk --no-cache add gcc musl-dev libffi-dev make

# Copy only the requirements file to leverage Docker cache
COPY requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the project files into the container
COPY . .

# Expose port 8000
EXPOSE 8000

# Install Gunicorn
RUN pip install gunicorn

# Command to run the application using Gunicorn
CMD ["gunicorn", "rufustechbackend.wsgi:application", "--bind", "0.0.0.0:8000", "--timeout", "300"]