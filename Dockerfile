FROM golang:alpine

RUN apk add dumb-init && apk add musl && apk add libgcc && apk add libstdc++ && apk add git

COPY code-server gopls /go/bin/

RUN mkdir -p /.vscode/User && mkdir -p /.vscode/extensions

COPY ./extensions/ms-vscode.go-0.11.7.tar /.vscode/extensions/

RUN  tar -xf /.vscode/extensions/ms-vscode.go-0.11.7.tar -C /.vscode/extensions/

COPY ./User/User/settings.json /.vscode/User

RUN mkdir -p /projects

WORKDIR /projects

VOLUME [ "/projects" ]

EXPOSE 8080

ENTRYPOINT ["code-server", "--host", "0.0.0.0", "--user-data-dir", "/.vscode/", "--extra-extensions-dir", "/.vscode/extensions", "--base-path", "/projects"]