FROM python:3.7-alpine AS build

RUN apk --no-cache add curl

RUN curl -s https://api.github.com/repos/kubernetes-sigs/kustomize/releases/latest |\
      grep browser_download |\
      grep linux |\
      cut -d '"' -f 4 |\
      xargs curl -O -L && \
    mv kustomize_*_linux_amd64 /kustomize && \
    chmod u+x /kustomize

RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.11.0/bin/linux/amd64/kubectl && \
    mv kubectl /kubectl && \
    chmod u+x /kubectl

FROM python:3.7-alpine

RUN apk add --no-cache bash jq
RUN pip install yq

COPY --from=build /kustomize /kustomize
COPY --from=build /kubectl /kubectl
COPY deploy.sh /deploy.sh

ENTRYPOINT ["/deploy.sh"]
