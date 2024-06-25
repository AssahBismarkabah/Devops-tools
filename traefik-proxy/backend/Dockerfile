FROM python:3.9-alpine

LABEL authors="bismark"

WORKDIR /app

COPY app.py /app/app.py

RUN pip install Flask

CMD ["python3", "app.py"]

