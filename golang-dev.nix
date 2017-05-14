{ config, pkgs, ... }:

{
  config = {

    environment.variables = {
          GOPATH = "$HOME/go";
    };

    environment.systemPackages = with pkgs; [
      gocode
      godep
      golint
      godef
      gotools
      ];
  };
}
