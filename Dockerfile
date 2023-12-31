FROM python:3.10.8-slim
RUN apt-get -y update
RUN apt-get install -y ffmpeg libavcodec-extra

WORKDIR /code

COPY requirements.txt ./

RUN pip install --no-cache-dir --upgrade -r /code/requirements.txt

RUN useradd -m -u 1000 user

USER user

ENV HOME=/home/user \
	PATH=/home/user/.local/bin:$PATH

WORKDIR $HOME/app

COPY --chown=user . $HOME/app/

EXPOSE 7860

CMD ["python", "app/app.py"]