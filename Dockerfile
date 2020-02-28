FROM nixos/nix

# XXX find a way to keep this value automatically in sync
# with the rask-default.
ARG nightly_version=2020-02-28

ENV RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME=/usr/local/cargo \
    PATH=/usr/local/cargo/bin:$PATH

RUN wget "https://raw.githubusercontent.com/TrueDoctor/ratatosk/master/shell.nix"; \
    nix-env -iA nixpkgs.rustup; \
    nix-shell; \
    rustup install nightly-${nightly_version}; \
    rustup default nightly-${nightly_version}; \
    rustup target add wasm32-unknown-unknown; \
    chmod -R a+w $RUSTUP_HOME $CARGO_HOME; \
    rustup --version; \
    cargo --version; \
    rustc --version;
