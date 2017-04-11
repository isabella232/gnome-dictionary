NULL =

AM_CPPFLAGS = \
	-I$(top_srcdir)/libgdict				\
	-I$(top_builddir)/libgdict				\
	-DG_LOG_DOMAIN=\"Gdict\" 				\
	-DDATADIR=\""$(datadir)"\" 				\
	-DLIBDIR=\""$(libdir)"\" 				\
	-DSYSCONFDIR=\""$(sysconfdir)"\" 			\
	-DPREFIX=\""$(prefix)"\" 				\
	-DGNOMELOCALEDIR=\""$(prefix)/$(DATADIRNAME)/locale"\"  \
	-DGDICTSOURCESDIR=\""$(datadir)/gdict-1.0/sources"\" 	\
	-DGDICT_ENABLE_INTERNALS=1 				\
	-DGDICT_MAJOR_VERSION=$(GDICT_MAJOR_VERSION)		\
	-DGDICT_MINOR_VERSION=$(GDICT_MINOR_VERSION)		\
	-DGDICT_MICRO_VERSION=$(GDICT_MICRO_VERSION)		\
	-DG_DISABLE_DEPRECATED					\
	-DGDK_DISABLE_DEPRECATED				\
	-UGTK_DISABLE_DEPRECATED				\
	-DPANGO_DISABLE_DEPRECATED				\
	-DG_DISABLE_SINGLE_INCLUDES				\
	-DGTK_DISABLE_SINGLE_INCLUDES				\
	$(NULL)

sources_h = \
	gdict-context.h			\
	gdict-client-context.h		\
	gdict-database-chooser.h 	\
	gdict-database-chooser-button.h \
	gdict-defbox.h 			\
	gdict-source-chooser.h		\
	gdict-source-loader.h		\
	gdict-source.h			\
	gdict-speller.h			\
	gdict-strategy-chooser.h 	\
	gdict-utils.h			\
	gdict.h				\
	$(NULL)

sources_h_priv = \
	gdict-context-private.h		\
	gdict-debug.h			\
	gdict-private.h			\
	$(NULL)

sources_c = \
	gdict-context.c			\
	gdict-client-context.c		\
	gdict-database-chooser.c	\
	gdict-database-chooser-button.c	\
	gdict-defbox.c			\
	gdict-source-chooser.c		\
	gdict-source-loader.c		\
	gdict-source.c			\
	gdict-speller.c			\
	gdict-strategy-chooser.c	\
	gdict-utils.c			\
	$(NULL)

BUILT_SOURCES = \
	gdict-enum-types.h	\
	gdict-enum-types.c	\
	gdict-marshal.h		\
	gdict-marshal.c

noinst_LTLIBRARIES = libgdict-1.0.la

# GNOME Dictionary shared library
libgdict_1_0_la_SOURCES = $(BUILT_SOURCES) $(sources_h)	$(sources_h_priv) $(sources_c)
libgdict_1_0_la_CFLAGS = $(GDICT_CFLAGS) $(GDICT_DEBUG_CFLAGS) $(MAINTAINER_CFLAGS)
libgdict_1_0_la_LIBADD = $(GDICT_LIBS)
libgdict_1_0_la_LDFLAGS = -export-dynamic -no-undefined

stamp_files = stamp-gdict-enum-types.h stamp-gdict-marshal.h

CLEANFILES = $(stamp_files) $(BUILT_SOURCES)
MAINTAINERCLEANFILES = $(stamp_files) $(gdict_built_files)

EXTRA_DIST = 			\
	gdict-enum-types.h.in	\
	gdict-enum-types.c.in	\
	gdict-marshal.list	\
	$(NULL)

gdict-marshal.h: stamp-gdict-marshal.h
	@true
stamp-gdict-marshal.h: gdict-marshal.list Makefile
	$(AM_V_GEN)$(GLIB_GENMARSHAL) \
	  $(srcdir)/gdict-marshal.list --header --prefix=gdict_marshal >> xgen-gmh \
	&& ( cmp -s xgen-gmh gdict-marshal.h || cp xgen-gmh gdict-marshal.h ) \
	&& rm -f xgen-gmh \
	&& echo timestamp > $@

gdict-marshal.c: gdict-marshal.list Makefile
	$(AM_V_GEN)( echo "#include \"gdict-marshal.h\""; echo; \
	  $(GLIB_GENMARSHAL) \
	  $(srcdir)/gdict-marshal.list --body --prefix=gdict_marshal ) >> xgen-gmc \
	&& cp xgen-gmc gdict-marshal.c \
	&& rm -f xgen-gmc

gdict-enum-types.h: stamp-gdict-enum-types.h
	@true
stamp-gdict-enum-types.h: $(sources_h) gdict-enum-types.h.in Makefile
	$(AM_V_GEN) $(GLIB_MKENUMS) --template $(srcdir)/gdict-enum-types.h.in \
	  $(addprefix $(srcdir)/,$(sources_h)) >> xgen-ceth \
	&& ( cmp -s xgen-ceth gdict-enum-types.h || cp xgen-ceth gdict-enum-types.h ) \
	&& rm -f xgen-ceth \
	&& echo timestamp > $@

gdict-enum-types.c: gdict-enum-types.h gdict-enum-types.c.in Makefile
	$(AM_V_GEN) $(GLIB_MKENUMS) --template $(srcdir)/gdict-enum-types.c.in \
	  $(addprefix $(srcdir)/,$(sources_h)) >> xgen-cetc \
	&& cp xgen-cetc gdict-enum-types.c \
	&& rm -f xgen-cetc

-include $(top_srcdir)/git.mk
