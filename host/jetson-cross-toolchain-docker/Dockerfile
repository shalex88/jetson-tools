# Stage 1: Extract archives and clean up
FROM nvcr.io/nvidia/jetpack-linux-aarch64-crosscompile-x86:6.1 AS extractor

WORKDIR /l4t

RUN mkdir toolchain \
 && tar -C toolchain -xf toolchain.tar.bz2 \
 && rm -f toolchain.tar.bz2 \
 && cat targetfs.tbz2.* > targetfs.tbz2 \
 && tar -I lbzip2 -xf targetfs.tbz2 \
 && rm -f targetfs.tbz2 targetfs.tbz2.*

# Stage 2: Final image with extracted files only
FROM nvcr.io/nvidia/jetpack-linux-aarch64-crosscompile-x86:6.1

WORKDIR /l4t

# Copy extracted files from the extractor stage
COPY --from=extractor /l4t/toolchain ./toolchain
COPY --from=extractor /l4t/targetfs ./targetfs