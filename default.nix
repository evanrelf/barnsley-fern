let
  haskellPackagesOverlay = pkgsNew: pkgsOld: {
    haskellPackages = pkgsOld.haskellPackages.override (old: {
      overrides =
        let
          extension =
            (pkgsNew.haskell.lib.packagesFromDirectory {
              directory = ./nix/haskell-packages;
            });
        in
          pkgsNew.lib.composeExtensions
            (old.overrides or (_: _: {}))
            extension;
    });
  };


  pkgs =
    import ./nix/nixpkgs.nix {
      overlays = [ haskellPackagesOverlay ];
      config = {};
    };


  barnsley-fern = pkgs.haskellPackages.barnsley-fern;


  executable = pkgs.haskell.lib.justStaticExecutables barnsley-fern;


  shell =
    barnsley-fern.env.overrideAttrs (old: {
      buildInputs = with pkgs; old.buildInputs ++ [
        cabal-install
        ghcid
        hlint
      ];
    });
in
  { inherit
      barnsley-fern
      executable
      shell
    ;
  }
