begin
  require 'spec'
rescue LoadError
  require 'rubygems'
  gem 'rspec'
  require 'spec'
end

$:.unshift(File.dirname(__FILE__) + '/../lib')
require 'subtitle_it'
include SubtitleIt

module SubFixtures
  def sub_fixture
    File.open(File.expand_path(File.dirname(__FILE__) + '/fixtures/pulpfiction.sub')) 
  end
  
  def srt_fixture
    File.open(File.expand_path(File.dirname(__FILE__) + '/fixtures/godfather.srt'))     
  end
  
  def yml_fixture
    File.open(File.expand_path(File.dirname(__FILE__) + '/fixtures/sincity.yml')) 
  end
  
  def rsb_fixture
    File.open(File.expand_path(File.dirname(__FILE__) + '/fixtures/pseudo.rsb')) 
  end 
  
  def xml_fixture
    File.open(File.expand_path(File.dirname(__FILE__) + '/fixtures/movie.xml')) 
  end  
  
  def mpl_fixture
    File.open(File.expand_path(File.dirname(__FILE__) + '/fixtures/puplfiction.mpl')) 
  end  
end