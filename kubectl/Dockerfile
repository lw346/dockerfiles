FROM alpine:3.10 AS build

ARG version=1.11.0
RUN apk --no-cache add curl

RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/v${version}/bin/linux/amd64/kubectl && \
    mv kubectl /kubectl && \
    chmod u+x /kubectl

FROM gcr.io/distroless/base

COPY --from=build /kubectl /kubectl

ENTRYPOINT ["/kubectl"]
