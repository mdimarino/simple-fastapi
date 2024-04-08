FROM python:3.11-slim

EXPOSE 8000

RUN apt-get update && \
    apt-get dist-upgrade -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata && \
    cp /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime && \
    echo "America/Sao_Paulo" > /etc/timezone && \
    useradd -m -u 10100 -s /bin/bash app

COPY --chown=app:app main.py requirements.txt /home/app/

RUN python -m pip install --upgrade pip && pip install --no-cache-dir -r /home/app/requirements.txt

USER app

WORKDIR /home/app

RUN chmod 755 ./main.py

CMD [ "./main.py" ]
