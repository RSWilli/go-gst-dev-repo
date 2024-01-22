# go-gst Development Environment

This repo contains the nix flake based development environment for [go-gst](https://github.com/go-gst/go-gst) and its associated [go-glib](https://github.com/go-gst/go-glib) bindings. I am using this to be able to build and develop the bindings on my linux machines. feel free to use it as well.

This repo uses `direnv` to automatically load the golang, gstreamer and all CGO dependencies into the environment.

There is a `initialize-subrepos` command that clones the go-gst and go-glib repos.
