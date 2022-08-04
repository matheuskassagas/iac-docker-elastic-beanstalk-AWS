FROM python:3

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /home/ubuntu/tcc

COPY . /home/ubuntu/tcc

RUN pip install -r requirements.txt

RUN sed -i "s/ALLOWED_HOST = []/ALLOWED_HOST = ['*']/"