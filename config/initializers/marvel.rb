$MARVEL_CONFIG = YAML.load_file(Rails.root.join('config/marvel.yml'))[Rails.env]
