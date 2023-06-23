FROM debian:bookworm AS build

RUN apt-get update
RUN apt-get install -y make gcc

COPY neper /neper

WORKDIR /neper
RUN make LDFLAGS=--static

FROM nicolaka/netshoot

COPY --from=build /neper/tcp_rr /usr/local/bin/tcp_rr
COPY --from=build /neper/tcp_stream /usr/local/bin/tcp_stream
COPY --from=build /neper/tcp_crr /usr/local/bin/tcp_crr
COPY --from=build /neper/udp_rr /usr/local/bin/udp_rr
COPY --from=build /neper/udp_stream /usr/local/bin/udp_stream
COPY --from=build /neper/psp_stream /usr/local/bin/psp_stream
COPY --from=build /neper/psp_crr /usr/local/bin/psp_crr
COPY --from=build /neper/psp_rr /usr/local/bin/psp_rr
