let
  # nixos-19.09 on 2020-02-17
  rev = "8731aaaf8b30888bc24994096db830993090d7c4";
  nixpkgs = builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/${rev}.tar.gz";
    sha256 = "1hcc89rxi47nb0mpk05nl9rbbb04kfw97xfydhpmmgh57yrp3zqa";
  };
in
  import nixpkgs
