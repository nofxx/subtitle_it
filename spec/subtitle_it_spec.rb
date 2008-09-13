require File.dirname(__FILE__) + '/spec_helper.rb'

# Time to add your specs!
# http://rspec.info/
describe SubtitleIt do
  
  it "should instantiate " do
    @sub = Subtitle.new(nil, "{12}{30}hey hey heypending", "sub")
    @sub.should be_instance_of(Subtitle)
  end
end