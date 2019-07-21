FROM golang:1.12 AS build

ENV GO111MODULE=on
RUN mkdir -p $GOPATH/src/github.com/google && \
    cd $GOPATH/src/github.com/google && \
    git clone https://github.com/lw346/go-containerregistry.git && \
    cd go-containerregistry && \
    go build -v ./... && \
    go install ./cmd/crane

FROM gcr.io/distroless/base

COPY --from=build /go/bin/crane /crane
ENTRYPOINT ["/crane"]
