#!/bin/sh
set -eu

# Argon is not part of the base feed set.
rm -rf package/thirdparty/luci-theme-argon \
       package/thirdparty/luci-app-argon-config
mkdir -p package/thirdparty
git clone --depth=1 https://github.com/jerrykuku/luci-theme-argon.git \
    package/thirdparty/luci-theme-argon
git clone --depth=1 https://github.com/jerrykuku/luci-app-argon-config.git \
    package/thirdparty/luci-app-argon-config

mkdir -p files/etc/uci-defaults

cat > files/etc/uci-defaults/99-luci-defaults <<'EOF'
#!/bin/sh

uci set luci.main.lang='zh_cn'
uci set luci.main.mediaurlbase='/luci-static/argon'
uci commit luci

exit 0
EOF

chmod 0755 files/etc/uci-defaults/99-luci-defaults
