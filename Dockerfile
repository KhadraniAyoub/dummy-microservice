FROM alpine:latest
RUN echo "Hello from dummy microservice"
CMD ["sh", "-c", "echo running && sleep 3600"]
