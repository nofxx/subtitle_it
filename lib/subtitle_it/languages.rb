module SubtitleIt
  #TODO: create a lang class?
  # now I`m more lost.... opensubtitle uses a 3 chars like
  # Por => Portuguese
  # Cze => Czech ....
  LANGS = {
    :aa =>  'Afar',
    :ab =>  'Abkhazian',
    :af =>  'Afrikaans',
    :ak =>  'Akan',
    :sq =>  'Albanian',
    :am =>  'Amharic',
    :ar =>  'Arabic',
    :pb =>  'Brazilian Portuguese',
    :hy =>  'Armenian',
    :bs =>  'Bosnian',
    :bg =>  'Bulgarian',
    :ca =>  'Catalan',
    :zh =>  'Chinese',
    :cs =>  'Czech',
    :da =>  'Danish',
    :nl =>  'Dutch',
    :et =>  'Estonian',
    :fr =>  'French',
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
    :pb =>  'Brazilian',
    :ay =>  'Assyrian',
    :en =>  'English'
  }

  OPSUB_LANGS = {
    # TODO : add the other languages id
    :fr => 'fra',
    :en => 'eng'
  }
end
