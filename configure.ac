dnl -*- mode: m4 -*-
m4_define([gdict_major_version], [3])
m4_define([gdict_minor_version], [25])
m4_define([gdict_micro_version], [1])
m4_define([gdict_version], [gdict_major_version.gdict_minor_version.gdict_micro_version])

AC_PREREQ(2.63)
AC_INIT([gnome-dictionary], [gdict_version],
	[http://bugzilla.gnome.org/enter_bug.cgi?product=gnome-dictionary],
	[gnome-dictionary],
	[http://live.gnome.org/GnomeUtils])

AC_CONFIG_HEADERS(config.h)
AC_CONFIG_SRCDIR([src])
AC_CONFIG_MACRO_DIR([m4])

AC_CANONICAL_TARGET

AM_INIT_AUTOMAKE([1.14 subdir-objects tar-ustar dist-xz no-dist-gzip foreign])
AM_SILENT_RULES([yes])
AM_MAINTAINER_MODE([enable])

AC_USE_SYSTEM_EXTENSIONS

AC_PROG_CC
AM_PROG_CC_C_O
AC_PROG_CXX
AC_HEADER_STDC
PKG_PROG_PKG_CONFIG([0.22])
AC_PROG_SED

AM_GNU_GETTEXT_VERSION([0.19.8])
AM_GNU_GETTEXT([external])
GETTEXT_PACKAGE=AC_PACKAGE_NAME
AC_DEFINE_UNQUOTED(GETTEXT_PACKAGE,"$GETTEXT_PACKAGE",[The name of the gettext domain])
AC_SUBST(GETTEXT_PACKAGE)

GLIB_MKENUMS=`$PKG_CONFIG --variable glib_mkenums glib-2.0`
GLIB_GENMARSHAL=`$PKG_CONFIG --variable glib_genmarshal glib-2.0`
GLIB_COMPILE_RESOURCES=`$PKG_CONFIG --variable glib_compile_resources gio-2.0`
AC_SUBST(GLIB_MKENUMS)
AC_SUBST(GLIB_GENMARSHAL)
AC_SUBST(GLIB_COMPILE_RESOURCES)

LT_PREREQ([2.2.6])
LT_INIT([disable-static win32-dll])
LT_LIB_M

## don't rerun to this point if we abort
AC_CACHE_SAVE

dnl Enable debug messages
m4_define([debug_default], [m4_if(m4_eval(gdict_minor_version % 2), [1], [yes], [minimum])])
AC_ARG_ENABLE([debug],
              [AS_HELP_STRING([--enable-debug=@<:@no/minimum/yes@:>@],
                              [Enable debug messages @<:@default=debug_default@:>@])],
              [],
              [enable_debug=debug_default])

AS_CASE([$enable_debug],

        [yes],
        [
          test "$cflags_set" = set || CFLAGS="$CFLAGS -g"
          GDICT_DEBUG_CFLAGS="-DGDICT_ENABLE_DEBUG"
        ],

        [minimum],
        [GDICT_DEBUG_CFLAGS="-DG_DISABLE_CAST_CHECKS"],

        [no],
        [GDICT_DEBUG_CFLAGS="-DG_DISABLE_ASSERT -DG_DISABLE_CHECKS -DG_DISABLE_CAST_CHECKS"],

        [*], [AC_MSG_ERROR([Unknown argument to --enable-debug])]
)

AC_SUBST(GDICT_DEBUG_CFLAGS)

AC_SUBST(GDICT_MAJOR_VERSION, [gdict_major_version])
AC_SUBST(GDICT_MINOR_VERSION, [gdict_minor_version])
AC_SUBST(GDICT_MICRO_VERSION, [gdict_micro_version])

dnl IPv6 support
msg_ipv6=no

AC_MSG_CHECKING([whether to enable IPv6])
AC_ARG_ENABLE([ipv6],
              [AS_HELP_STRING([--enable-ipv6=@<:@yes/no@:>@],
                              [Enables compilation of IPv6 code])],
              [],
              [enable_ipv6=yes])

AS_IF([test "x$enable_ipv6" = "xyes"],
      [
        AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[
            #include <sys/socket.h>
            #include <sys/types.h>
          ]], [[
            struct sockaddr_storage ss;
            socket(AF_INET6, SOCK_STREAM, 0)
          ]])],
          [have_ipv6=yes],
          [have_ipv6=no]
        )
      ]
)

AS_IF([test "x$have_ipv6" = "xyes"],
      [
        have_getaddrinfo=no
        AC_CHECK_FUNC(getaddrinfo, have_getaddrinfo=yes)

        AS_IF([test "x$have_getaddrinfo" != "xyes"],
              [
                for lib in bsd socket inet; do
                  AC_CHECK_LIB($lib,
                               [getaddrinfo],
                               ["LIBS=$LIBS -l$lib"; have_getaddrinfo=yes; break])
                done
              ]
        )

        AS_IF([test "x$have_getaddrinfo" = "xyes"],
              [
              AC_DEFINE([ENABLE_IPV6], [1], [Define whether IPv6 support is enabled])
              msg_ipv6=yes
              ]
        )
      ]
)

GLIB_GSETTINGS

YELP_HELP_INIT

GLIB_MIN_VERSION=2.42.0
GTK_MIN_VERSION=3.21.1

PKG_CHECK_MODULES(GDICT,
                  glib-2.0 >= $GLIB_MIN_VERSION
                  gtk+-3.0 >= $GTK_MIN_VERSION)

AC_CONFIG_FILES([
        Makefile
        libgdict/Makefile
        data/Makefile
        docs/Makefile
        help/Makefile
        src/Makefile
	po/Makefile.in
])

AC_OUTPUT

dnl ==========================================================================
echo "

        GNOME Dictionary $VERSION
        =========================

        prefix: ${prefix}
        compiler: ${CC}

        IPv6 support: ${msg_ipv6}
"
