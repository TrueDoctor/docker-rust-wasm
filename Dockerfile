FROM nixos/nix

# XXX find a way to keep this value automatically in sync
# with the rask-default.
ARG nightly_version=-2020-07-26
#ARG nightly_version=""

ENV RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME=/usr/local/cargo \
    PATH=/usr/local/cargo/bin:$PATH

# nix-channel --update needed to make sure we are at latest `nixos-unstable`.
# Unfortunately, the current `nixos/nix:latest` is pretty far behind and misses
# (at least) the following rustup bugfix: https://github.com/NixOS/nixpkgs/pull/92615
RUN nix-channel --update

RUN wget "https://raw.githubusercontent.com/TrueDoctor/ratatosk/master/shell.nix"; \
    nix-env -iA nixpkgs.rustup; \
    nix-shell; \
    rustup install nightly${nightly_version}; \
    rustup default nightly${nightly_version}; \
    rustup component add rust-src; \
    rustup target add wasm32-unknown-unknown; \
    chmod -R a+w $RUSTUP_HOME $CARGO_HOME; \
    rustup --version; \
    cargo --version; \
    rustc --version;
