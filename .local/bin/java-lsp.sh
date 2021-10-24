#!/bin/bash

# export JDTLS_HOME="$HOME/.config/nvim/jdtls"

JAR="$HOME/.local/share/nvim/lsp_servers/jdtls/plugins/org.eclipse.equinox.launcher*.jar"
GRADLE_HOME=gradle java \
  -Declipse.application=org.eclipse.jdt.ls.core.id1 \
  -Dosgi.bundles.defaultStartLevel=4 \
  -Declipse.product=org.eclipse.jdt.ls.core.product \
  -Dlog.protocol=true \
  -Dlog.level=ALL \
  -Xms1g \
  -Xmx2G \
  -jar $(echo "$JAR") \
  -configuration "$HOME/.local/share/nvim/lsp_servers/jdtls/config_linux" \
  -data "${1:-$HOME/.workspace}" \
  --add-modules=ALL-SYSTEM \
  --add-opens java.base/java.util=ALL-UNNAMED \
  --add-opens java.base/java.lang=ALL-UNNAMED
