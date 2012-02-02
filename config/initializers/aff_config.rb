_config_path_dicts = File.join(Rails.root, "config", "dicts")
_config_path_used = File.join(_config_path_dicts, 'used')

RMMSeg::Config.dictionaries += [
  [File.join(_config_path_used, 'a.dict'), false]
]

RMMSeg::Dictionary::instance.reload