appdata_conf = configuration_data()
appdata_conf.set('application_id', application_id)
i18n.merge_file('appdata',
  input: configure_file(
    input: 'org.gnome.Dictionary.appdata.xml.in.in',
    output: 'org.gnome.Dictionary.appdata.xml.in',
    configuration: appdata_conf,
  ),
  output: application_id + '.appdata.xml',
  install: true,
  install_dir: gdict_datadir / 'metainfo',
  po_dir: po_dir,
)

appstream_util = find_program('appstream-util', required: false)
if appstream_util.found()
  test('validate-appdata',
    appstream_util,
    args: [ 'validate', '--nonet', application_id + '.appdata.xml' ],
    workdir: meson.current_build_dir(),
  )
endif

