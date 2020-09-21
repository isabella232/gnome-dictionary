app_sources = [
  'gdict-about.c',
  'gdict-app.c',
  'gdict-app.h',
  'gdict-common.c',
  'gdict-pref-dialog.c',
  'gdict-print.c',
  'gdict-sidebar.c',
  'gdict-source-dialog.c',
  'gdict-window.c',
  'main.c',
]

resources = gnome.compile_resources ('gdict-resources',
  'gdict.gresource.xml',
  source_dir: '.',
  c_name: 'gdict',
)

gdict_cflags = [
  '-DPREFIX="@0@"'.format(gdict_prefix),
  '-DSYSCONFDIR="@0@"'.format(gdict_sysconfdir),
  '-DLIBDIR="@0@"'.format(gdict_libdir),
  '-DDATADIR="@0@"'.format(gdict_datadir),
  '-DPKGDATADIR="@0@"'.format(join_paths(gdict_datadir, 'gnome-dictionary')),
  '-DGNOMELOCALEDIR="@0@"'.format(join_paths(gdict_datadir, 'locale')),
  '-DAPPLICATION_ID="@0@"'.format(application_id),
]

if profile == 'devel' or gdict_minor_version in ['alpha', 'beta', 'rc']
  gdict_cflags += [
    '-DDEVELOPMENT_BUILD',
  ]
endif

mathlib = cc.find_library('m', required: false)

executable('gnome-dictionary',
  sources: app_sources + resources,
  c_args: gdict_cflags,
  dependencies: [ libgdict_dep, mathlib ],
  include_directories: root_inc,
  install: true,
)
