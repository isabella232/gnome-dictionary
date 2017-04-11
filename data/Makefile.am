NULL =

EXTRA_DIST =
CLEANFILES =

man_MANS = gnome-dictionary.1
EXTRA_DIST += $(man_MANS)

gdictappdir = $(datadir)/applications
gdictapp_in_files = org.gnome.Dictionary.desktop.in
gdictapp_DATA = $(gdictapp_in_files:.desktop.in=.desktop)
EXTRA_DIST += $(gdictapp_in_files)
CLEANFILES += $(gdictapp_DATA)

@INTLTOOL_DESKTOP_RULE@

dbusservicedir = $(datadir)/dbus-1/services
dbusservice_in_files = org.gnome.Dictionary.service.in
dbusservice_DATA = $(dbusservice_in_files:.service.in=.service)

org.gnome.Dictionary.service: $(dbusservice_in_files) Makefile
	$(AM_V_GEN) $(SED) -e 's|\@bindir\@|@bindir@|' $< > $@

EXTRA_DIST += $(dbusservice_in_files)
CLEANFILES += $(dbusservice_DATA)

@INTLTOOL_XML_RULE@
appdatadir = $(datadir)/appdata
appdata_DATA = $(appdata_in_files:.xml.in=.xml)
appdata_in_files = org.gnome.Dictionary.appdata.xml.in
EXTRA_DIST += \
	$(appdata_in_files) \
	$(gsettings_SCHEMAS) \
	$(NULL)
CLEANFILES += $(appdata_DATA)

# dictionary sources definitions
dictsourcedir = $(datadir)/gdict-1.0/sources
dictsource_in_files = \
	default.desktop.in \
	spanish.desktop.in \
	thai.desktop.in \
	$(NULL)
dictsource_DATA = $(dictsource_in_files:.desktop.in=.desktop)
@INTLTOOL_DESKTOP_RULE@

EXTRA_DIST += $(dictsource_in_files)
CLEANFILES += $(dictsource_DATA)

gsettings_SCHEMAS = org.gnome.dictionary.gschema.xml

@GSETTINGS_RULES@

# Flatpak manifest
EXTRA_DIST += org.gnome.Dictionary.json

-include $(top_srcdir)/git.mk
