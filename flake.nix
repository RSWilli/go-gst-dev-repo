{
  description = "Golang+gstreamer dev environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self , nixpkgs ,... }: let
    system = "x86_64-linux";
  in {
    devShells."${system}".default = let
      pkgs = import nixpkgs {
        inherit system;
      };

      initScript = pkgs.writeShellScriptBin "initialize-subrepos" ''
          #!/usr/bin/env bash
          git clone git@github.com:go-gst/go-gst.git
          git clone git@github.com:go-gst/go-glib.git
          '';
    in pkgs.mkShell {
      packages = with pkgs; [
        go
        pkg-config
        initScript
        # Video/Audio data composition framework tools like "gst-inspect", "gst-launch" ...
        gst_all_1.gstreamer
        # Common plugins like "filesrc" to combine within e.g. gst-launch
        gst_all_1.gst-plugins-base
        # Specialized plugins separated by quality
        gst_all_1.gst-plugins-good
        gst_all_1.gst-plugins-bad
        gst_all_1.gst-plugins-ugly
        # Plugins to reuse ffmpeg to play almost every video format
        gst_all_1.gst-libav
        # Support the Video Audio (Hardware) Acceleration API
        gst_all_1.gst-vaapi
      ];

      GO111MODULE="on";
    };
  };
}