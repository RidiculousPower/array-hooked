
module ::HookedArray::Interface

  instances_identify_as!( ::HookedArray )
  
  ################
  #  initialize  #
  ################

  # Initialize with reference a configuration instance.
  # @param [Object] object Object that HookedArray instance is attached to, primarily useful for
  #  reference from hooks.
  # @param [Array<Object>] args Parameters passed through super to Array#initialize.
  # @return [true,false] Whether receiver identifies as object.
  def initialize( configuration_instance = nil, *args )
    
    @configuration_instance = configuration_instance

    super( *args )
        
  end

  ############################
  #  configuration_instance  #
  ############################

  attr_accessor :configuration_instance
  
end
