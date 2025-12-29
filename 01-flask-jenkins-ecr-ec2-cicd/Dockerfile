# syntax=docker/dockerfile:1
FROM python:3.12-slim

ENV PYTHONDONTWRITEBYTECODE=1     PYTHONUNBUFFERED=1

WORKDIR /srv

# Create non-root user
RUN useradd -m appuser

COPY app/requirements.txt /srv/requirements.txt
RUN pip install --no-cache-dir -r /srv/requirements.txt

COPY app /srv/app
COPY run.py /srv/run.py

EXPOSE 5000

HEALTHCHECK --interval=10s --timeout=3s --retries=5 CMD python -c "import urllib.request; urllib.request.urlopen('http://127.0.0.1:5000/health').read()"

USER appuser

CMD ["gunicorn", "-b", "0.0.0.0:5000", "run:app", "--workers", "2", "--threads", "4", "--timeout", "60"]
