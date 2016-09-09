with import <nixpkgs> {};

# { stdenv, fetchurl }:

# { stdenv, buildGoPackage, fetchFromGitHub,  go, which,  makeWrapper, iptables, rsync, utillinux, coreutils, e2fsprogs, procps-ng, python,  git, openssl }:

#
stdenv.mkDerivation rec {
  name = "docker-machine-${version}";
  version = "0.7.0";

  src = fetchurl {
    url = "https://github.com/docker/machine/releases/download/v0.7.0/docker-machine-Linux-x86_64";
    sha256 = "21e490d5cdfa0d21e543e06b73180614f72e6c18a940f476a64cf084cea23aa5";
  };

  phases = "installPhase";
  # addCVars  addToSearchPath

  installPhase = ''
  mkdir -p "$out/bin/"
  cp -R $src "$out/bin/docker-machine"
  chmod +x "$out/bin/docker-machine"
  '';

  meta = with stdenv.lib; {
    description = "Docker Machine is a tool that lets you install Docker Engine on virtual hosts, and manage the hosts with docker-machine commands.";
    license = licenses.asl20;
    homepage = https://kubernetes.io/docs/getting-started-guides/minikube/;
    maintainers = with maintainers; [offline];
    platforms = [ "x86_64-linux" ];
  };
}
