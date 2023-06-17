FROM debian:bookworm AS build

RUN apt-get update
RUN apt-get install -y make gcc

COPY neper /neper

WORKDIR /neper
RUN make

FROM debian:bookworm-slim

COPY --from=build /neper/tcp_rr /bin/tcp_rr
COPY --from=build /neper/tcp_stream /bin/tcp_stream
COPY --from=build /neper/tcp_crr /bin/tcp_crr
COPY --from=build /neper/udp_rr /bin/udp_rr
COPY --from=build /neper/udp_stream /bin/udp_stream
COPY --from=build /neper/psp_stream /bin/psp_stream
COPY --from=build /neper/psp_crr /bin/psp_crr
COPY --from=build /neper/psp_rr /bin/psp_rr
