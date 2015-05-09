require File.dirname(__FILE__) + '/spec_helper.rb'

# Time to add your specs!
# http://rspec.info/
describe SubtitleIt do
  
  it "should instantiate " do
    @sub = Subtitle.new({:dump => "{12}{30}hey hey heypending", :format => "sub"})
    expect(@sub).to be_instance_of(Subtitle)
  end
end