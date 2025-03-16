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
          };

          nativeBuildInputs = with pkgs; [
            trunk
            lld
            wasm-bindgen-cli
          ];

          buildPhase = ''
            export HOME=$(mktemp -d)
            trunk build --release --public-url ./
          '';
          installPhase = "cp -r dist $out";
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
