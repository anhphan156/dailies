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
        packages.default = pkgs.rustPlatform.buildRustPackage {
          name = "Dailies";
          src = ./.;
          cargoLock = {
            lockFile = ./Cargo.lock;
            outputHashes = {
              "yew-0.21.0" = "sha256-P4KbppLUqnstU3JM9E3wNXOngJ0ePYLZC9LU7yPcMfQ=";
            };
          };
          cargoVendorDir = "./.";
          buildPhase = ''
            export HOME=$(mktemp -d)
            trunk build
          '';
          installPhase = "cp -r dist $out";

          nativeBuildInputs = with pkgs; [
            trunk
          ];
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
