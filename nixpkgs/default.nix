let
  # https://vaibhavsagar.com/blog/2018/05/27/quick-easy-nixpkgs-pinning/
  inherit (import <nixpkgs> {}) fetchgit;

  # nixos channel latest 19.03 2019-06-26
  # keep the Dockerfile in sync with this!
  channel = fetchgit {
   url = "https://github.com/NixOs/nixpkgs-channels.git";
   rev = "8634c3b619909db7fc747faf8c03592986626e21";
   sha256 = "0hcpy4q64vbqmlmnfcavfxilyygyzpwdsss8g3p73ikpic0j6ziq";
  };

  # the mozilla rust overlay
  # allows us to track cargo nightlies in a nixos friendly way
  # avoids rustup
  # not compatible with parallel rustup installation
  moz-overlay = import (builtins.fetchTarball https://github.com/mozilla/nixpkgs-mozilla/tarball/200cf0640fd8fdff0e1a342db98c9e31e6f13cd7);

  pkgs = import channel {
   overlays = [ moz-overlay ];
  };
in
pkgs
