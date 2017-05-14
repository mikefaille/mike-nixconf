{ config, pkgs, ... }:

{
  config = {

    environment.variables = {
          GOPATH = "$HOME/go";
    };

    environment.systemPackages = with pkgs; [
      go_1_8
      gocode
      godep
      golint
      godef
      gotools
      ];
  };
}
