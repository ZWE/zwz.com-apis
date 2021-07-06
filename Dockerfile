FROM golang:1.14 as builder
WORKDIR /go/src/zwz.com/demos/
ARG ARCH="amd64"
ARG OS="linux"
COPY main.go .

#RUN apt-get update  

RUN git config --global http.sslVerify false  

RUN go get -insecure github.com/ZWE/zwz.com-apis  
    
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o main . 

FROM alpine:latest

WORKDIR /root/

COPY --from=builder /go/src/zwz.com/demos/ .

CMD ["./main"]

