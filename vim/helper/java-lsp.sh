#!/usr/bin/env bash

# Reference: https://github.com/autozimu/LanguageClient-neovim/wiki/Java

# Set repo's parent directory
server=$HOME

java \
    -Declipse.application=org.eclipse.jdt.ls.core.id1 \
    -Dosgi.bundles.defaultStartLevel=4 \
    -Declipse.product=org.eclipse.jdt.ls.core.product \
    -noverify \
    -Xms1G \
    -jar $server/eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository/plugins/org.eclipse.equinox.launcher_1.*.jar \
    -configuration $server/eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository/config_linux/ \
    "$@"

# below options not necessary? (old version used these)
# -Dlog.level=ALL \
# --add-modules=ALL-SYSTEM \
# --add-opens java.base/java.util=ALL-UNNAMED \
# --add-opens java.base/java.lang=ALL-UNNAMED \
