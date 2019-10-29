FROM golang:alpine

RUN apk add dumb-init && apk add musl && apk add libgcc && apk add libstdc++ && apk add git

# code-server download from https://github.com/cdr/code-server releases, you should choose alpine version corresponding with docker environment. 
# gopls built from source code, see https://github.com/golang/tools/tree/master/gopls, included in the code base. 
# gopls build issues: it must be built in alpine environment, because its clib is not same with other linux dist, which is musl, 
#                     so you can mount the source code in a alpine docker, then build in the docker 
COPY code-server gopls /go/bin/

RUN mkdir -p /.vscode/User && mkdir -p /.vscode/extensions
# vs-code golang extension should be included, you can choose newer versions.
COPY ./extensions/ms-vscode.go-0.11.7.tar /.vscode/extensions/
RUN  tar -xf /.vscode/extensions/ms-vscode.go-0.11.7.tar -C /.vscode/extensions/

# copy gopls config into docker, you can modify it according to your needs.
COPY ./User/User/settings.json /.vscode/User

RUN mkdir -p /projects

WORKDIR /projects

# This ensures we have a volume mounted even if the user forgot to do bind
# mount. So that they do not lose their data if they delete the container.
VOLUME [ "/projects" ]

EXPOSE 8080

ENTRYPOINT ["dumb-init", "code-server", "--host", "0.0.0.0", "--user-data-dir", "/.vscode/", "--extra-extensions-dir", "/.vscode/extensions", "--base-path", "/projects"]