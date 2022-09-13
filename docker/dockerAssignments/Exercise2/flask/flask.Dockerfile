FROM python:3.8.2-alpine
RUN mkdir /flask
RUN pip3 install redis
RUN pip3 install flask 
RUN pip3 install flask_session
WORKDIR /flask
COPY ./app.py .
CMD ["/flask/app.py"]
ENTRYPOINT ["python"]


