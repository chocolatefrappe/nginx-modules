ARG VERSION=1.28.2

FROM scratch AS rustup-init-amd64
ARG VERSION
ADD --chmod=0755 \
    https://static.rust-lang.org/rustup/archive/${VERSION}/x86_64-unknown-linux-musl/rustup-init /rustup-init

FROM scratch AS rustup-init-ppc64le
ARG VERSION
ADD --chmod=0755 \
    https://static.rust-lang.org/rustup/archive/${VERSION}/powerpc64le-unknown-linux-musl/rustup-init /rustup-init

FROM scratch AS rustup-init-arm64
ARG VERSION
ADD --chmod=0755 \
    https://static.rust-lang.org/rustup/archive/${VERSION}/aarch64-unknown-linux-musl/rustup-init /rustup-init

FROM rustup-init-${TARGETARCH}${TARGETVARIANT} AS rustup-init
FROM rustup-init
