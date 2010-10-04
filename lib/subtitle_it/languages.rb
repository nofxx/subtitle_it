module SubtitleIt
  #  opensubtitle uses a 3 chars like
  # Por => Portuguese
  # Cze => Czech ....
  #
  # LANGUAGE /  HUMAN NAME /  OPENSUBTITLE CODE
  #
  # Need to rewrite "Portuguese" => [:pt, :por, :whatever]
  LANGS = {
    :aa =>  'Afar',
    :ab =>  'Abkhazian',
    :af =>  'Afrikaans',
    :ak =>  'Akan',
    :ay =>  'Assyrian',
    :sq =>  'Albanian',
    :am =>  'Amharic',
    :ar =>  'Arabic',
    :br =>  ['Brazilian', 'por'],
    :hy =>  'Armenian',
    :bs =>  'Bosnian',
    :bg =>  'Bulgarian',
    :ca =>  'Catalan',
    :cs =>  'Czech',
    :da =>  'Danish',
    :nl =>  'Dutch',
    :en =>  ['English','eng'],
    :et =>  'Estonian',
    :fr =>  ['French', 'fra'],
    :de =>  'German',
    :gl =>  'Galician',
    :el =>  'Greek',
    :he =>  'Hebrew',
    :hi =>  'Hindi',
    :hr =>  'Croatian',
    :hu =>  'Hungarian',
    :is =>  'Icelandic',
    :id =>  'Indonesian',
    :it =>  'Italian',
    :ja =>  'Japanese',
    :kk =>  'Kazakh',
    :ko =>  'Korean',
    :lv =>  'Latvian',
    :lt =>  'Lithuanian',
    :lb =>  'Luxembourgish',
    :mk =>  'Macedonian',
    :ms =>  'Malay',
    :no =>  'Norwegian',
    :pl =>  'Polish',
    :pt =>  'Portuguese',
    :ru =>  'Russian',
    :sr =>  'Serbian',
    :es =>  'Spanish',
    :sk =>  'Slovak',
    :sl =>  'Slovenian',
    :sv =>  'Swedish',
    :th =>  'Thai',
    :tr =>  'Turkish',
    :uk =>  'Ukrainian',
    :vi =>  'Vietnamese',
    :ro =>  'Romanian',
    :zh =>  'Chinese'
  }

end
