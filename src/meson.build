cc = meson.get_compiler('c')

conf = configuration_data()
conf.set_quoted('PACKAGE_NAME', meson.project_name())
conf.set_quoted('PACKAGE_VERSION', meson.project_version())
conf.set_quoted('PACKAGE_STRING', '@0@-@1@'.format(meson.project_name(), meson.project_version()))
conf.set_quoted('PACKAGE_DATADIR', gdict_datadir)
conf.set_quoted('PACKAGE_LIBDIR', gdict_libdir)
conf.set_quoted('PACKAGE_LOCALE_DIR', join_paths(gdict_datadir, 'locale'))
conf.set_quoted('PACKAGE_LIBEXECDIR', gdict_libexecdir)
conf.set('VERSION', 'PACKAGE_VERSION')
conf.set('GETTEXT_PACKAGE', 'PACKAGE_NAME')
conf.set('LOCALEDIR', 'PACKAGE_LOCALE_DIR')
conf.set10('ENABLE_NLS', true) # Always enabled
conf.set('HAVE_UNISTD_H', cc.has_header('unistd.h'))

# Compiler flags
if cc.get_id() == 'gcc' or cc.get_id() == 'clang'
  test_cflags = [
    '-fno-strict-aliasing',
    '-Wno-c++11-extensions',
    '-Wno-missing-include-dirs',
    '-Wno-typedef-redefinition',
    '-Wcast-align',
    '-Wduplicated-branches',
    '-Wduplicated-cond',
    '-Wformat=2',
    '-Wformat-nonliteral',
    '-Wformat-security',
    '-Wignored-qualifiers',
    '-Wimplicit-function-declaration',
    '-Wlogical-op',
    '-Wmisleading-indentation',
    '-Wmissing-format-attribute',
    '-Wmissing-include-dirs',
    '-Wmissing-noreturn',
    '-Wnested-externs',
    '-Wnull-dereference',
    '-Wold-style-definition',
    '-Wpointer-arith',
    '-Wshadow',
    '-Wstrict-prototypes',
    '-Wundef',
    '-Wuninitialized',
    '-Wunused',
    '-Werror=address',
    '-Werror=array-bounds',
    '-Werror=empty-body',
    '-Werror=implicit',
    '-Werror=implicit-fallthrough',
    '-Werror=init-self',
    '-Werror=int-to-pointer-cast',
    '-Werror=main',
    '-Werror=missing-braces',
    '-Werror=missing-declarations',
    '-Werror=missing-prototypes',
    '-Werror=nonnull',
    '-Werror=pointer-to-int-cast',
    '-Werror=redundant-decls',
    '-Werror=return-type',
    '-Werror=sequence-point',
    '-Werror=trigraphs',
    '-Werror=vla',
    '-Werror=write-strings',
  ]
else
  test_cflags = []
endif

common_cflags = cc.get_supported_arguments(test_cflags)

debug_cflags = []
if debug
  debug_cflags += '-DGDICT_ENABLE_DEBUG'
elif optimization in ['2', '3', 's']
  debug_cflags += '-DG_DISABLE_CAST_CHECKS'
endif

if buildtype == 'release'
  debug_cflags += [ '-DG_DISABLE_ASSERT', '-DG_DISABLE_CHECKS', '-DG_DISABLE_CAST_CHECKS', ]
endif

ipv6_deps = []

if use_ipv6
  ipv6_prog = '''
#include <sys/socket.h>
#include <sys/types.h>

int main (void) {
  struct sockaddr_storage ss;
  socket(AF_INET6, SOCK_STREAM, 0);
  return 0;
}
  '''
  has_ipv6 = cc.compiles(ipv6_prog, name: 'AF_INET6 is available')
  has_getaddrinfo = cc.has_function('getaddrinfo')

  # Look for getaddrinfo in all the known places
  if not has_getaddrinfo
    found_getaddrinfo = false
    foreach l: [ 'bsd', 'socket', 'inet' ]
      dep = cc.find_library(l, required: false)
      if not found_getaddrinfo and dep.found()
        has_getaddrinfo = cc.has_function('getaddrinfo', dependencies: dep)
        if has_getaddrinfo
          ipv6_deps += dep
        endif
      endif
    endforeach
  endif

  use_ipv6 = has_ipv6 and has_getaddrinfo
endif

conf.set10('ENABLE_IPV6', use_ipv6)

configure_file(output: 'config.h', configuration: conf)

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
  '-DGDICT_MAJOR_VERSION=@0@'.format(gdict_major_version),
  '-DGDICT_MINOR_VERSION=@0@'.format(gdict_minor_version),
  '-DGDICT_MICRO_VERSION=@0@'.format(gdict_micro_version),
]

if profile == 'devel' or gdict_is_devel
  gdict_cflags += [
    '-DDEVELOPMENT_BUILD',
  ]
endif

mathlib = cc.find_library('m', required: false)

gio_dep = dependency('gio-2.0', version: '>= 2.42.0')
gtk_dep = dependency('gtk+-3.0', version: '>= 3.21.2')

executable('gnome-dictionary',
  sources: [ app_sources, gdict_enums, gdict_marshal, gdict_resources ],
  c_args: [ common_cflags, debug_cflags, gdict_cflags ],
  dependencies: [ gio_dep, gtk_dep, ipv6_deps, mathlib ],
  install: true,
)
