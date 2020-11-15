eval "$(find /usr/local/linkedin/etc/bash /export/content/linkedin/etc/bash 2>/dev/null -type f -exec cat {} \;)"

export JAVA_HOME=$(/usr/libexec/java_home)
export PATH="/usr/local/opt/nss/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/nss/lib -L/usr/local/opt/openblas/lib"
export CPPFLAGS="-I/usr/local/opt/nss/include -I/usr/local/opt/openblas/include"
export BROWSER=open

export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
