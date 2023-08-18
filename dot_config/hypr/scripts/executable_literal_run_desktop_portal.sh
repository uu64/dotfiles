#!/bin/sh

# usage: $0 portal-name [enable/disable]
# args:
#     portal-name: the name of the .portal file in /usr/share/xdg-desktop-portal/portals/ without the extension
#     [enable/disable]: optional - whether to move the file into $ENABLED_PORTAL_DIR to enable it,
#                              or to move it into $DISABLED_PORTAL_DIR to disable it. The portal will be toggled
#                              if this argument is omitted.

ENABLED_PORTAL_DIR="/usr/share/xdg-desktop-portal/portals"
# needs to be created manually
DISABLED_PORTAL_DIR="/usr/share/xdg-desktop-portal/disabled-portals"

is_portal_enabled() {
  [ -f "$ENABLED_PORTAL_DIR/$1.portal" ]
}

is_portal_disabled() {
  [ -f "$DISABLED_PORTAL_DIR/$1.portal" ]
}

enable_portal() {
  mv "$DISABLED_PORTAL_DIR/$1.portal" "$ENABLED_PORTAL_DIR/$1.portal"
}

disable_portal() {
  mv "$ENABLED_PORTAL_DIR/$1.portal" "$DISABLED_PORTAL_DIR/$1.portal"
}

remove_disabled_portal() {
  rm "$DISABLED_PORTAL_DIR/$1.portal"
}

PORTAL=$1
ENABLE=${2:-$(is_portal_enabled "$PORTAL" && echo "disable" || echo "enable")}

if [ "$ENABLE" = "enable" ]; then
  if is_portal_enabled "$PORTAL"; then
    # remove disabled portal if enabled portal exists as well,
    # as the enabled portal is most likely a newly installed version
    is_portal_disabled "$PORTAL" && remove_disabled_portal "$PORTAL"
  else
    is_portal_disabled "$PORTAL" && enable_portal "$PORTAL"
  fi
else
  is_portal_enabled "$PORTAL" && disable_portal "$PORTAL"
fi
