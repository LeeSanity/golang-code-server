# A portable golang IDE

it is built with docker based on [code server](https://github.com/cdr/code-server) and go language server.

try it out yourself, prepare requirements according to the [Dockerfile](https://github.com/LeeSanity/golang-code-server/blob/master/Dockerfile) before build

```
    docker build -t code-server:v1 .
    docker run -p 8080:8080 -v "${HOME}/workspace:/projects" code-server:v1
```

there maybe more args for code-server, see the offical document.
