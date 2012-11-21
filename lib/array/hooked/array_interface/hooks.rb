
module ::Array::Hooked::ArrayInterface::Hooks

  ##################
  #  pre_set_hook  #
  ##################

  ###
  # A hook that is called before setting a value; return value is used in place of object.
  #
  # @param [Integer] index 
  #
  #        Index at which set/insert is taking place.
  #
  # @param [Object] object 
  #
  #        Element being set/inserted.
  #
  # @param [true,false] is_insert 
  #
  #        Whether this set is inserting a new index.
  #
  # @param [Integer] length 
  #
  #        Length of set if other than 1.
  #
  # @return [Object] 
  #
  #         Return value is used in place of object.
  #
  def pre_set_hook( index, object, is_insert = false, length = nil )

    return object
    
  end

  ###################
  #  post_set_hook  #
  ###################

  ###
  # A hook that is called after setting a value.
  #
  # @param [Integer] index 
  #
  #        Index at which set/insert is taking place.
  #
  # @param [Object] object 
  #
  #        Element being set/inserted.
  #
  # @param [true,false] is_insert 
  #
  #        Whether this set is inserting a new index.
  #
  # @param [Integer] length 
  #
  #        Length of set if other than 1.
  #
  # @return [Object] 
  #
  #         Ignored.
  #
  def post_set_hook( index, object, is_insert = false, length = nil )
    
    return object
    
  end

  ##################
  #  pre_get_hook  #
  ##################

  ###
  # A hook that is called before getting a value; if return value is false, get does not occur.
  #
  # @param [Integer] index 
  #
  #        Index at which set/insert is taking place.
  #
  # @param [Integer] length 
  #
  #        Length of get if other than 1.
  #
  # @return [true,false] 
  #
  #         If return value is false, get does not occur.
  #
  def pre_get_hook( index, length = nil )
    
    # false means get does not take place
    return true
    
  end

  ###################
  #  post_get_hook  #
  ###################

  ###
  # A hook that is called after getting a value.
  #
  # @param [Integer] index 
  #
  #        Index at which get is taking place.
  #
  # @param [Object] object 
  #
  #        Element retrieved.
  #
  # @param [Integer] length 
  #
  #        Length of get if other than 1.
  #
  # @return [Object] 
  #
  #         Object returned in place of get result.
  #
  def post_get_hook( index, object, length = nil )
    
    return object
    
  end

  #####################
  #  pre_delete_hook  #
  #####################

  ###
  # A hook that is called before deleting a value; if return value is false, delete does not occur.
  #
  # @param [Integer] index 
  #
  #        Index at which delete is taking place.
  #
  # @return [true,false] 
  #
  #         If return value is false, delete does not occur.
  #
  def pre_delete_hook( index )
    
    # false means delete does not take place
    return true
    
  end

  ######################
  #  post_delete_hook  #
  ######################

  ###
  # A hook that is called after deleting a value.
  #
  # @param [Integer] index 
  #
  #        Index at which delete took place.
  #
  # @param [Object] object 
  #
  #        Element deleted.
  #
  # @return [Object] 
  #
  #         Object returned in place of delete result.
  #
  def post_delete_hook( index, object )
    
    return object
    
  end

end
