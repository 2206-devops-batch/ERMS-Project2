# Pull an official base image
FROM python:3.10-slim-bullseye

# Setting work directory
WORKDIR /flask-calculator

COPY . /flask-calculator


# Install dependencies
RUN pip install -r requirements.txt

EXPOSE 3000

# Run Server
CMD ["python3", "app.py"]