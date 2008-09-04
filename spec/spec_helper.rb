begin
  require 'spec'
rescue LoadError
  require 'rubygems'
  gem 'rspec'
  require 'spec'
end

$:.unshift(File.dirname(__FILE__) + '/../lib')
require 'subtitle_it'
#include SubtitleIt



class Carro
  @@rodas = 4
end

describe Carro do
 it "deve ter 4 rodas" do
    carro = Carro.new
    carro.rodas.should eql(4)
  end
  
  
  
end