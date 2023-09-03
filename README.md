# lambda-provided.al2

Experiment provided.al2 environment with GOlang lambda

This is basic lambda function that is comes with serverless initial template.
This is has 2 options one is to use lambda file as x86_64 and other is to use lambda file as arm64.

## Things to know

With new aws provided lambda runtime required you to name you binary as `bootstrap`, And this is use as the entrypoint to the lambda.
In this project, I have created the binary as `hello` and `world` as normally how we name them on soon to be deprecated go1.x runtime.
But created a shell script which named as `bootstrap` which basically point to each binary.

## How to use

You can basically use the makefile to deploy each version. By default it will display x86_64 version.

```bash
make deploy # deploy x86_64 version
make deploy ARCH=arm64 # deploy arm64 version
```
