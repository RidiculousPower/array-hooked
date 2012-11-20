
module ::Array::Hooked::ArrayInterface::Undecorated

  #####################
  #  undecorated_set  #
  #####################

  ###
  # Alias to original #[]= method. Used to perform actual set between hooks.
  #
  # @param [Integer] index
  # 
  #        Index at which set is taking place.
  #
  # @param [Object] object 
  #
  #        Element being set.
  #
  # @return [Object] 
  #
  #         Element set.
  #
  def undecorated_set( index, value )
    
    return @internal_array[ index ] = value
    
  end
  
  #####################
  #  undecorated_get  #
  #####################

  ###
  # Alias to original #[] method. Used to perform actual get between hooks.
  #
  # @param [Integer] index 
  #
  #        Index at which get is requested.
  #
  # @return [Object] 
  #
  #         Element requested.
  #
  def undecorated_get( index )
    
    return @internal_array[ index ]
    
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
