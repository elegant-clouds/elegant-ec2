# NOTE:
# ----
# As Retype is developed using .NET and is built to native binary, so there is no need for Node.js at all.
FROM debian:bullseye-slim AS build
# NOTE:
# ----
# This makes use of NPM Registry API (used by `npm`) to fetch the tarball of package `retype-linux-x64` [1].
# The URL and shasum can be found at https://registry.npmjs.org/retypeapp-linux-x64/
# Thanks to @fabriciomurta for the tip [2]!
#
# [1]: https://www.npmjs.com/package/retypeapp-linux-x64
# [2]: https://gist.github.com/Genzer/22c40a2e3d65e13c81903e3dd6874c42#gistcomment-4000189
ARG RETYPE_PACKAGE_URL="https://registry.npmjs.org/retypeapp-linux-x64/-/retypeapp-linux-x64-1.11.2.tgz"
ARG RETYPE_PACKAGE_SHASUM="df1f7f19fa793508d892f2004b6e218e7a3e62be"

SHELL [ "/bin/bash", "-c"]
WORKDIR /opt/

RUN set -ueo pipefail; \
  apt-get update \
  && apt-get install -y --no-install-recommends \
      curl \
      ca-certificates \
  && curl  "$RETYPE_PACKAGE_URL" \ 
    | tee >(tar -xz --strip-components=2 -f- package/bin/retype) \
    | sha1sum -c <(echo "$RETYPE_PACKAGE_SHASUM -") \
  && chmod +x retype

FROM debian:bullseye-slim AS final

WORKDIR /retype
# This is to suppress the error
# "Couldn't find a valid ICU package installed on the system.".
ENV DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=1

# These packages has to be install as `retype` is dynamically linked
# with several libs.
ARG PACKAGES="\
  libgssapi-krb5-2 \
  libssl-dev \
"

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    $PACKAGES \
  && rm -rf /var/lib/apt/lists/*

COPY --from=build /opt/retype /usr/local/bin/retype
COPY . .
