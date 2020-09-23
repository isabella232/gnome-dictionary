project('gnome-dictionary', 'c', version: '40.alpha',
        default_options: [
          'buildtype=debugoptimized',
          'c_std=c99',
          'warning_level=1',
        ],
        license: 'GPLv2+',
        meson_version: '>= 0.54.0')

gdict_version = meson.project_version().split('.')
gdict_major_version = gdict_version[0].to_int()
gdict_minor_version = gdict_version[1] in ['alpha', 'beta', 'rc'] ? 0 : libgdict_version[1].to_int()
gdict_micro_version = 0

gdict_is_devel = gdict_version[1] in ['alpha', 'beta', 'rc']

gdict_prefix = get_option('prefix')
gdict_bindir = gdict_prefix / get_option('bindir')
gdict_libdir = gdict_prefix / get_option('libdir')
gdict_datadir = gdict_prefix / get_option('datadir')
gdict_includedir = gdict_prefix / get_option('includedir')
gdict_libexecdir = gdict_prefix / get_option('libexecdir')
gdict_mandir = gdict_prefix / get_option('mandir')
gdict_sysconfdir = gdict_prefix / get_option('sysconfdir')
gdict_schemadir = gdict_datadir / 'glib-2.0' / 'schemas'
gdict_servicedir = gdict_datadir / 'dbus-1' / 'services'

profile = get_option('profile')
debug = get_option('debug')
optimization = get_option('optimization')
buildtype = get_option('buildtype')
use_ipv6 = get_option('use_ipv6')

if profile == 'devel' or gdict_is_devel
  application_id = 'org.gnome.Dictionary.Devel'
else
  application_id = 'org.gnome.Dictionary'
endif

po_dir = join_paths(meson.current_source_dir(), 'po')

gnome = import('gnome')
i18n = import('i18n')

subdir('src')
subdir('po')
subdir('data')
subdir('help')

# Post-installation trigger
meson.add_install_script('build-aux/meson/post-install.py')
