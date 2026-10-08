# Overlay of google-ctf 2023/quals/pwn-write-flag-where/challenge/Dockerfile (vendored unchanged in app/).
# What differs from upstream:
# - a first stage builds `chal` with the challenge's own Makefile: kCTF expects `make -C challenge`
#   before `docker build`, and the archive does not commit the binary. It builds on the same base
#   image as the chroot, so the binary links against the libc the challenge runs with;
# - the COPY sources point into app/challenge/ (this folder is the build context), and the
#   binary comes from that first stage.
# Everything else is upstream's, line for line.

FROM ubuntu@sha256:7a57c69fe1e9d5b97c5fe649849e79f2cfc3bf11d10bbd5218b4eb61716aebe6 AS build
RUN apt-get update && apt-get install -y --no-install-recommends gcc make libc6-dev && rm -rf /var/lib/apt/lists/*
COPY app/challenge/ /src/
RUN make -C /src chal

FROM ubuntu@sha256:7a57c69fe1e9d5b97c5fe649849e79f2cfc3bf11d10bbd5218b4eb61716aebe6 as chroot

RUN /usr/sbin/useradd --no-create-home -u 1000 user

COPY app/challenge/flag /
COPY app/challenge/flag /home/user/flag.txt
COPY app/challenge/flag /flag.txt
COPY --from=build /src/chal /home/user/

FROM gcr.io/kctf-docker/challenge@sha256:d884e54146b71baf91603d5b73e563eaffc5a42d494b1e32341a5f76363060fb

COPY --from=chroot / /chroot

COPY app/challenge/nsjail.cfg /home/user/

CMD kctf_setup && \
    kctf_drop_privs \
    socat \
      TCP-LISTEN:1337,reuseaddr,fork \
      EXEC:"kctf_pow nsjail --config /home/user/nsjail.cfg -- /home/user/chal"
