libgdict_version = meson.project_version().split('.')
libgdict_major = libgdict_version[0].to_int()
libgdict_minor = libgdict_version[1] in ['alpha', 'beta', 'rc'] ? 0 : libgdict_version[1].to_int()
libgdict_micro = 0

gdict_headers = [
  'gdict-context.h',
  'gdict-client-context.h',
  'gdict-database-chooser.h',
  'gdict-database-chooser-button.h',
  'gdict-defbox.h',
  'gdict-source-chooser.h',
  'gdict-source-loader.h',
  'gdict-source.h',
  'gdict-speller.h',
  'gdict-strategy-chooser.h',
  'gdict-utils.h',
]

app_sources = [
  'gdict-about.c',
  'gdict-app.c',
  'gdict-app.h',
  'gdict-client-context.c',
  'gdict-common.c',
  'gdict-context.c',
  'gdict-database-chooser.c',
  'gdict-database-chooser-button.c',
  'gdict-defbox.c',
  'gdict-pref-dialog.c',
  'gdict-print.c',
  'gdict-sidebar.c',
  'gdict-source-chooser.c',
  'gdict-source-dialog.c',
  'gdict-source-loader.c',
  'gdict-source.c',
  'gdict-speller.c',
  'gdict-strategy-chooser.c',
  'gdict-utils.c',
  'gdict-window.c',
  'main.c',
]

gdict_enums = gnome.mkenums('gdict-enum-types',
  sources: gdict_headers,
  h_template: 'gdict-enum-types.h.in',
  c_template: 'gdict-enum-types.c.in',
  install_header: false,
)

gdict_marshal = gnome.genmarshal('gdict-marshal',
  sources: 'gdict-marshal.list',
  prefix: 'gdict_marshal',
)

gdict_resources = gnome.compile_resources('gdict-resources',
  'gdict.gresource.xml',
  source_dir: '.',
  c_name: 'gdict',
)

gdict_cflags = [
  '-D_GNU_SOURCE',
  '-DG_LOG_DOMAIN="Gdict"',
  '-DG_LOG_USE_STRUCTURED=1',
  '-DPREFIX="@0@"'.format(gdict_prefix),
  '-DSYSCONFDIR="@0@"'.format(gdict_sysconfdir),
  '-DLIBDIR="@0@"'.format(gdict_libdir),
  '-DDATADIR="@0@"'.format(gdict_datadir),
  '-DPKGDATADIR="@0@"'.format(join_paths(gdict_datadir, 'gnome-dictionary')),
  '-DGNOMELOCALEDIR="@0@"'.format(join_paths(gdict_datadir, 'locale')),
  '-DAPPLICATION_ID="@0@"'.format(application_id),
  '-DGDICTSOURCESDIR="@0@"'.format(join_paths(gdict_datadir, 'gdict-1.0', 'sources')),
  '-DGDICT_ENABLE_INTERNALS=1',
  '-DGDICT_MAJOR_VERSION=@0@'.format(libgdict_major),
  '-DGDICT_MINOR_VERSION=@0@'.format(libgdict_minor),
  '-DGDICT_MICRO_VERSION=@0@'.format(libgdict_micro),
]

if profile == 'devel' or gdict_minor_version in ['alpha', 'beta', 'rc']
  gdict_cflags += [
    '-DDEVELOPMENT_BUILD',
  ]
endif

mathlib = cc.find_library('m', required: false)

executable('gnome-dictionary',
  sources: [ app_sources, gdict_enums, gdict_marshal, gdict_resources ],
  c_args: gdict_cflags,
  dependencies: [ gio_dep, gtk_dep, ipv6_deps, mathlib ],
  include_directories: root_inc,
  install: true,
)
