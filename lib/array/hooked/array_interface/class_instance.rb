# -*- encoding : utf-8 -*-

module ::Array::Hooked::ArrayInterface::ClassInstance
  
  ################################
  #  new_without_internal_array  #
  ################################

  ###
  # Create Array::Hooked instance with reference to a configuration instance but without internal array.
  #
  # @param [Object] configuration_instance 
  # 
  #        Object that instance will be attached to; primarily useful for reference from hooks.
  #
  def new_without_internal_array( configuration_instance = nil )

    instance = allocate
    
    instance.initialize_without_internal_array( configuration_instance )
    
    return instance

  end
  
  ########
  #  []  #
  ########
  
  ###
  # Return a new Array instance populated with the given objects.
  #
  # @overload []( object, ... )
  #
  #   @param object
  #   
  #          [Object]
  #
  #          Object to add to new instance.
  #
  #   @return [Array::Hooked]
  #
  #           New Array instance.
  #
  def []( *objects )
    
    return new( nil, objects )
    
  end
  
  #################
  #  try_convert  #
  #################
  
  ###
  # Tries to convert object into an Array instance using #to_ary method. 
  #   Returns the converted array or nil if obj cannot be converted for any reason. 
  #   This method can be used to check if an argument is an array.
  #
  # @param object
  #
  #        [Object]
  #
  #        Object to attempt to convert.
  #
  # @return [Array::Hooked,nil]
  #
  #         Converted Array instance or nil if conversion was not possible.
  #
  def try_convert( object )
    
    converted_object = nil
    
    case object
      when ::Array::Hooked
        converted_object = object
      else
        if object.respond_to?( :to_ary )
          case attempted_conversion = object.to_ary
            when nil
              # we failed - done
            when ::Array::Hooked
              converted_object = attempted_conversion
            when ::Array
              converted_object = self.new_without_internal_array( @configuration_instance )
              converted_object.internal_array = attempted_conversion
          end
        end
    end
    
    return converted_object
    
  end
  
end
