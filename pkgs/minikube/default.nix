with import <nixpkgs> {};

# { stdenv, fetchurl }:

# { stdenv, buildGoPackage, fetchFromGitHub,  go, which,  makeWrapper, iptables, rsync, utillinux, coreutils, e2fsprogs, procps-ng, python,  git, openssl }:

#
stdenv.mkDerivation rec {
  name = "minikube-${version}";
  version = "0.9.0";

  src = fetchurl {
    url = "https://storage.googleapis.com/minikube/releases/v0.9.0/minikube-linux-amd64";
    sha256 = "76b341aa377c274c7147e203483f117ef01151a8e33bb232e29872ad20f6effc";
  };

  phases = "installPhase";
  # addCVars  addToSearchPath

  installPhase = ''
  mkdir -p "$out/bin/"
  cp -R $src "$out/bin/minikube"
  chmod +x "$out/bin/minikube"
  '';

  # src = fetchFromGitHub {
  #   owner = "kubernetes";
  #   repo = "minikube";
  #   rev = "v${version}";
  #   sha256 = "06224ca9ghf6axs5r318zmwv8f2j3gx141rqhgqmgdy8pyyji19k";
  # };



  # goPackagePath = "k8s.io/minikube";

  # buildInputs = [  which iptables rsync python go openssl git  ];

  # makeFlags = [ "out/localkube" ];
  # buildphase = ''
  # export GOPATH=$(pwd):$(pwd)/Godeps/_workspace
  # mkdir -p $(pwd)/Godeps/_workspace/src/k8s.io/
  # ln -s $(pwd) $(pwd)/Godeps/_workspace/src/k8s.io/minikube
  # echo $(pwd)/Godeps/_workspace/src/k8s.io/minikube/
  # '';
  # # ( cd $(pwd)/Godeps/_workspace/src/k8s.io/minikube && godep restore ./... )
  # # (echo $GOPATH)
  # # (cd $(pwd)/Godeps/_workspace/src/k8s.io/minikube; godep restore)
  # # substituteInPlace "hack/lib/golang.sh" --replace "_cgo" ""
  # # patchShebangs ./hack
  # # hack/build-go.sh --use_go_build
  # # (cd cluster/addons/dns/kube2sky && go build ./kube2sky.go)
  # # ( cd $(pwd)/Godeps/_workspace/src/k8s.io/minikube && make out/localkube )

  # doCheck = false;

  # # installPhase = ''
  # # # mkdir -p "$out/bin" "$out"/libexec/kubernetes/cluster
  # # # cp _output/local/go/bin/{kube*,hyperkube} "$out/bin/"
  # # # cp cluster/addons/dns/kube2sky/kube2sky "$out/bin/"
  # # # cp cluster/saltbase/salt/helpers/safe_format_and_mount "$out/libexec/kubernetes"
  # # # cp -R hack "$out/libexec/kubernetes"
  # # # cp cluster/update-storage-objects.sh "$out/libexec/kubernetes/cluster"
  # # makeWrapper "$out"/libexec/kubernetes/cluster/update-storage-objects.sh "$out"/bin/kube-update-sto
  # # '';

  # # preFixup = ''
  # #   # wrapProgram "$out/bin/kube-proxy" --prefix PATH : "${iptables}/bin"
  # #   # wrapProgram "$out/bin/kubelet" --prefix PATH : "${stdenv.lib.makeBinPath [ utillinux procps-ng ]}"
  # #   # chmod +x "$out/libexec/kubernetes/safe_format_and_mount"
  # #   # wrapProgram "$out/libexec/kubernetes/safe_format_and_mount" --prefix PATH : "${stdenv.lib.makeBinPath [ e2fsprogs utillinux ]}"
  # #   # substituteInPlace "$out"/libexec/kubernetes/cluster/update-storage-objects.sh \
  # #   #   --replace KUBE_OUTPUT_HOSTBIN KUBE_BIN
  # # '';

  meta = with stdenv.lib; {
    description = "Run Kubernetes locally";
    license = licenses.asl20;
    homepage = https://kubernetes.io/docs/getting-started-guides/minikube/;
    maintainers = with maintainers; [offline];
    platforms = [ "x86_64-linux" ];
  };
}
