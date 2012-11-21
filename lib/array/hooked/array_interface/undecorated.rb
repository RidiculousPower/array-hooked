
module ::Array::Hooked::ArrayInterface::Undecorated

  #####################
  #  undecorated_set  #
  #####################

  ###
  # Alias to original #[]= method. Used to perform actual set between hooks.
  #
  # @overload []( index, object )
  #
  #   @param [Integer] index 
  #   
  #          Index at which get is requested.
  #
  #   @param [Object] object 
  #   
  #          Element being set.
  #
  # @overload []( start, length, object )
  #
  #   @param [Integer] start 
  #   
  #          Index at which get slice begins.
  #   
  #   @param [Integer] length 
  #   
  #          Length of get.
  #
  #   @param [Object] object 
  #   
  #          Element being set.
  #
  # @overload []( range, object )
  #
  #   @param [Range] range 
  #   
  #          Range describing get slice.
  #
  #   @param [Object] object 
  #   
  #          Element being set.
  #
  # @return [Object] 
  #
  #         Element set.
  #
  def undecorated_set( *args )
    
    return @internal_array.[]=( *args )
    
  end
  
  #####################
  #  undecorated_get  #
  #####################

  ###
  # Alias to original #[] method. Used to perform actual get between hooks.
  #
  # @overload []( index )
  #
  #   @param [Integer] index 
  #   
  #          Index at which get is requested.
  #
  # @overload []( start, length )
  #
  #   @param [Integer] start 
  #   
  #          Index at which get slice begins.
  #   
  #   @param [Integer] length 
  #   
  #          Length of get.
  #
  # @overload []( range )
  #
  #   @param [Range] range 
  #   
  #          Range describing get slice.
  #
  # @return [Object] 
  #
  #         Element requested.
  #
  def undecorated_get( *args )
    
    return_value = nil
    
    index = args[ 0 ]
    length = args[ 1 ]
    
    if length or index.is_a?( ::Range )
      return_value = self.class::WithoutInternalArray.new( @configuration_instance )
      return_value.internal_array = @internal_array[ *args ]
    else
      return_value = @internal_array[ index ]
    end
    
    return return_value
    
  end

  ########################
  #  undecorated_insert  #
  ########################

  ###
  # Alias to original #insert method. Used to perform actual insert between hooks.
  #
  # @overload undecorated_insert( index, object, ... )
  #
  #   @param [Integer] index 
  #   
  #          Index at which insert is taking place.
  #   
  #   @param [Object] object
  #   
  #          Elements being inserted.
  #
  # @return [Object] 
  #
  #         Elements inserted.
  #
  def undecorated_insert( index, *objects )
    
    return @internal_array.insert( index, *objects )
    
  end

  ###########################
  #  undecorated_delete_at  #
  ###########################

  ###
  # Alias to original #delete method. Used to perform actual delete between hooks.
  #
  # @param [Integer] index 
  #
  #        Index at which delete is taking place.
  #
  # @return [Object] 
  #
  #         Element deleted.
  #
  def undecorated_delete_at( index )
    
    return @internal_array.delete_at( index )
    
  end
  
end
