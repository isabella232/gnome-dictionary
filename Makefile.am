SUBDIRS = libgdict src data help po

ACLOCAL_AMFLAGS = -I m4 ${ACLOCAL_FLAGS}

meson_build = \
	meson.build \
	meson_options.txt \
	data/meson.build \
	help/meson.build \
	libgdict/meson.build \
	po/meson.build \
	src/meson.build \
	$()

EXTRA_DIST = TODO README AUTHORS COPYING.docs COPYING.libs $(meson_build)

MAINTAINERCLEANFILES = \
	$(GITIGNORE_MAINTAINERCLEANFILES_TOPLEVEL)	\
	$(GITIGNORE_MAINTAINERCLEANFILES_MAKEFILE_IN)	\
	$(GITIGNORE_MAINTAINERCLEANFILES_M4_LIBTOOL)

-include $(top_srcdir)/git.mk
