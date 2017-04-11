i18n.merge_file ('desktop',
                 input: 'org.gnome.Dictionary.desktop.in',
                 output: 'org.gnome.Dictionary.desktop',
                 install: true,
                 install_dir: join_paths(gdict_datadir, 'applications'),
                 po_dir: po_dir,
                 type: 'desktop')

i18n.merge_file ('desktop',
                 input: 'org.gnome.Dictionary.appdata.xml.in',
                 output: 'org.gnome.Dictionary.appdata.xml',
                 install: true,
                 install_dir: join_paths(gdict_datadir, 'appdata'),
                 po_dir: po_dir)

service_conf = configuration_data ()
service_conf.set ('bindir', gdict_bindir)
configure_file (input: 'org.gnome.Dictionary.service.in',
                output: 'org.gnome.Dictionary.service',
                configuration: service_conf,
                install_dir: gdict_servicedir)

install_data ('org.gnome.dictionary.gschema.xml',
              install_dir: gdict_schemadir)


# Dictionary sources
sources = [
  'default.desktop',
  'spanish.desktop',
  'thai.desktop',
]

foreach s: sources
  i18n.merge_file('desktop',
                  input: '@0@.in'.format(s),
                  output: s,
                  install: true,
                  install_dir: join_paths(gdict_datadir, 'gdict-1.0', 'sources'),
                  po_dir: po_dir,
                  type: 'desktop')
endforeach
