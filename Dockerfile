FROM nixos/nix

ENV RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME=/usr/local/cargo \
    PATH=/usr/local/cargo/bin:$PATH

RUN wget "https://raw.githubusercontent.com/TrueDoctor/ratatosk/master/shell.nix"; \
    nix-shell; \
    nix-env -iA nixpkgs.rustup; \
    rustup install nightly-2020-02-24; \
    rustup default nightly-2020-02-24; \
    rustup target add wasm32-unknown-unknown; \
    cargo install cargo-make; \
    chmod -R a+w $RUSTUP_HOME $CARGO_HOME; \
    rustup --version; \
    cargo --version; \
    rustc --version;
