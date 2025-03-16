{
  description = "Rust Project";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    rust-overlay.url = "github:oxalica/rust-overlay";
  };
  outputs = {
    nixpkgs,
    flake-utils,
    rust-overlay,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [
            (import rust-overlay)
            (final: _: {
              rust-toolchain = final.rust-bin.fromRustupToolchainFile ./rust-toolchain.toml;
            })
          ];
        };
      in {
        packages.default = pkgs.stdenvNoCC.mkDerivation {
          name = "Dailies";
          src = ./.;
          nativeBuildInputs = with pkgs; [trunk rust-toolchain];
          buildPhase = ''
            export HOME=$(mktemp -d)
            export CARGO_NET_GIT_FETCH_WITH_CLI=true
            trunk build --release --public-url ./dailies
          '';
          installPhase = ''
            cp -r ./dist $out
          '';
        };
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            rust-toolchain
            act
            trunk
          ];
        };
      }
    );
}
