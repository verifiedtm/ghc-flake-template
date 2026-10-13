{
  description = "A Haskell development shell";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
        ghcVersion = "984";
        ghc = pkgs.haskell.compiler.${"ghc${ghcVersion}"};
      in
      {
        devShells.default = pkgs.mkShell {
          packages = [
            ghc

            # haskell tools
            pkgs.cabal-install
            pkgs.hpack
            pkgs.hlint
            pkgs.fourmolu

            # other tools
            pkgs.just
            pkgs.fd
          ];
        };
      }
    );
}
