
require_relative '../lib/hooked-array.rb'

describe ::HookedArray do
  
  it 'acts just like an ::Array::Hooked but takes a configuration instance' do
    configuration_instance = ::Module.new
    instance = ::HookedArray.new( configuration_instance )
    instance.configuration_instance.should == configuration_instance
    instance.is_a?( ::Array::Hooked ).should == true
  end
  
end
