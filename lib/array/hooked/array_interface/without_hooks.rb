# -*- encoding : utf-8 -*-

module ::Array::Hooked::ArrayInterface::WithoutHooks

  #######################
  #  get_without_hooks  #
  #######################

  # Alias to #[] that bypasses hooks.
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
  #         Element returned.
  #
  def get_without_hooks( *args )
    
    @without_hooks = true

    object = self[ *args ]
    
    @without_hooks = false
    
    return object
    
  end

  #######################
  #  set_without_hooks  #
  #######################

  ###
  # Alias to #[]= that bypasses hooks.
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
  #         Element returned.
  #
  def set_without_hooks( *args )
    
    @without_hooks = true

    self.[]=( *args )
    
    @without_hooks = false
    
    return object
    
  end

  ##########################
  #  insert_without_hooks  #
  ##########################

  ###
  # Alias to #insert that bypasses hooks.
  #
  # @overload insert_without_hooks( index, object, ... )
  #
  #   @param [Integer] index 
  #   
  #          Index at which set is taking place.
  #   
  #   @param [Object] object
  #   
  #          Elements being inserted.
  #
  # @return [Object] 
  #
  #         Element returned.
  #
  def insert_without_hooks( index, *objects )

    @without_hooks = true

    insert( index, *objects )
    
    @without_hooks = false

    return objects

  end

  ########################
  #  push_without_hooks  #
  ########################

  ###
  # Alias to #push that bypasses hooks.
  #
  # @overload push_without_hooks( object, ... )
  #
  #   @param [Object] object
  #   
  #          Elements being pushed.
  #
  # @return [Array<Object>] 
  #
  #         Element(s) pushed.
  #
  def push_without_hooks( *objects )

    @without_hooks = true

    push( *objects )
    
    @without_hooks = false

    return objects

  end

  ##########################
  #  concat_without_hooks  #
  ##########################

  ###
  # Alias to #concat that bypasses hooks.
  #
  # @param [Array<Object>] objects 
  #
  #        Elements being concatenated.
  #
  # @return [Object] 
  #
  #         Element returned.
  #
  def concat_without_hooks( *arrays )

    @without_hooks = true

    concat( *arrays )
    
    @without_hooks = false

    return arrays

  end

  ##########################
  #  delete_without_hooks  #
  ##########################

  ###
  # Alias to #delete that bypasses hooks.
  #
  # @param [Object] object 
  #
  #        Element being deleted.
  #
  # @return [Object] 
  #
  #         Element returned.
  #
  def delete_without_hooks( object )

    @without_hooks = true

    return_value = delete( object )
    
    @without_hooks = false

    return return_value

  end

  ##################################
  #  delete_objects_without_hooks  #
  ##################################

  ###
  # Alias to #delete that bypasses hooks and takes multiple objects.
  #
  # @param [Array<Object>] objects 
  #
  #        Elements being deleted.
  #
  # @return [Object] 
  #
  #         Element returned.
  #
  def delete_objects_without_hooks( *objects )

    @without_hooks = true

    return_value = delete_objects( *objects )
    
    @without_hooks = false

    return return_value

  end

  #############################
  #  delete_at_without_hooks  #
  #############################

  ###
  # Alias to #delete_at that bypasses hooks.
  #
  # @param [Integer] index 
  #
  #        Index to delete.
  #
  # @return [Object] 
  #
  #         Deleted element.
  #
  def delete_at_without_hooks( index )

    @without_hooks = true

    object = delete_at( index )
    
    @without_hooks = false

    return object
    
  end

  #####################################
  #  delete_at_indexes_without_hooks  #
  #####################################

  ###
  # Alias to #delete_at that bypasses hooks and takes multiple indexes.
  #
  # @param [Array<Integer>] index 
  #
  #        Index to delete.
  #
  # @return [Object] 
  #
  #         Deleted element.
  #
  def delete_at_indexes_without_hooks( *indexes )
    
    @without_hooks = true

    objects = delete_at_indexes( *indexes )
    
    @without_hooks = false
  
    return objects
    
  end
  
  #############################
  #  delete_if_without_hooks  #
  #############################

  ###
  # Alias to #delete_if that bypasses hooks.
  #
  # @yield 
  #
  #   Block passed to #delete_if.
  #
  # @return [Object] 
  #
  #         Deleted element.
  #
  def delete_if_without_hooks( & block )

    @without_hooks = true

    delete_if( & block )
    
    @without_hooks = false

    return self

  end

  ###########################
  #  keep_if_without_hooks  #
  ###########################

  ###
  # Alias to #keep_if that bypasses hooks.
  #
  # @yield 
  #
  #   Block passed to #keep_if.
  #
  # @return [Object] 
  #
  #         Deleted element.
  #
  def keep_if_without_hooks( & block )

    @without_hooks = true

    keep_if( & block )
    
    @without_hooks = false

    return self

  end

  ############################
  #  compact_without_hooks!  #
  ############################

  ###
  # Alias to #compact that bypasses hooks.
  #
  # @return [Object] 
  #
  #         Self.
  #
  def compact_without_hooks!

    @without_hooks = true

    compact!
    
    @without_hooks = false

    return self

  end

  ############################
  #  flatten_without_hooks!  #
  ############################

  ###
  # Alias to #flatten that bypasses hooks.
  #
  # @return [Object] 
  #
  #         Self.
  #
  def flatten_without_hooks!

    @without_hooks = true

    return_value = flatten!
    
    @without_hooks = false

    return return_value

  end

  ###########################
  #  reject_without_hooks!  #
  ###########################

  ###
  # Alias to #reject that bypasses hooks.
  #
  # @yield 
  #
  #   Block passed to #keep_if.
  #
  # @return [Object] 
  #
  #         Self.
  #
  def reject_without_hooks!( & block )

    @without_hooks = true

    reject!( & block )
    
    @without_hooks = false

    return return_value

  end

  ###########################
  #  replace_without_hooks  #
  ###########################

  ###
  # Alias to #replace that bypasses hooks.
  #
  # @param [Array] other_array 
  #
  #        Other array to replace self with.
  #
  # @return [Object] 
  #
  #         Self.
  #
  def replace_without_hooks( other_array )
    
    @without_hooks = true

    replace( other_array )
    
    @without_hooks = false
    
    return self
    
  end
  
  ############################
  #  reverse_without_hooks!  #
  ############################

  ###
  # Alias to #reverse that bypasses hooks.
  #
  # @return [Object] 
  #
  #         Self.
  #
  def reverse_without_hooks!

    @without_hooks = true

    reverse!
    
    @without_hooks = false

    return self

  end

  ###########################
  #  rotate_without_hooks!  #
  ###########################

  ###
  # Alias to #rotate that bypasses hooks.
  #
  # @param [Integer] rotate_count 
  #
  #        Integer count of how many elements to rotate.
  #
  # @return [Object] 
  #
  #         Self.
  #
  def rotate_without_hooks!( rotate_count = 1 )

    @without_hooks = true

    rotate!( rotate_count )
    
    @without_hooks = false

    return self

  end
  
  ###########################
  #  select_without_hooks!  #
  ###########################

  ###
  # Alias to #select that bypasses hooks.
  #
  # @yield 
  #
  #   Block passed to #select!.
  #
  # @return [Object] 
  #
  #         Self.
  #
  def select_without_hooks!( & block )
  
    @without_hooks = true

    select!( & block )
    
    @without_hooks = false
  
    return self
  
  end
  
  ############################
  #  shuffle_without_hooks!  #
  ############################

  ###
  # Alias to #shuffle that bypasses hooks.
  #
  # @param [Object] random_number_generator 
  #
  #        Random number generator passed to #shuffle!.
  #
  # @return [Object] 
  #
  #         Self.
  #
  def shuffle_without_hooks!( random_number_generator = nil )

    @without_hooks = true

    shuffle!( random_number_generator )
    
    @without_hooks = false

    return self

  end

  ############################
  #  collect_without_hooks!  #
  #  map_without_hooks!      #
  ############################

  ###
  # Alias to #select that bypasses hooks.
  #
  # @yield 
  #
  #   Block passed to #collect!.
  #
  # @return [Object] 
  #
  #         Self.
  #
  def collect_without_hooks!( & block )
    
    @without_hooks = true

    collect!( & block )
    
    @without_hooks = false
    
    return self
    
  end
  
  alias_method :map_without_hooks!, :collect_without_hooks!
  
  #########################
  #  sort_without_hooks!  #
  #########################

  ###
  # Alias to #sort that bypasses hooks.
  #
  # @yield 
  #
  #   Block passed to #sort!.
  #
  # @return [Object] 
  #
  #         Self.
  #
  def sort_without_hooks!( & block )
    
    @without_hooks = true

    sort!
    
    @without_hooks = false
    
    return self
    
  end
  
  ############################
  #  sort_by_without_hooks!  #
  ############################

  ###
  # Alias to #sort_by! that bypasses hooks.
  #
  # @yield 
  #
  #   Block passed to #sort_by!.
  #
  # @return [Object] 
  #
  #         Self.
  #
  def sort_by_without_hooks!( & block )
    
    @without_hooks = true

    sort_by!( & block )
    
    @without_hooks = false
    
    return self
    
  end
  
  #########################
  #  uniq_without_hooks!  #
  #########################

  ###
  # Alias to #uniq! that bypasses hooks.
  #
  # @return [Object] 
  #
  #         Self.
  #
  def uniq_without_hooks!

    @without_hooks = true

    return_value = uniq!
    
    @without_hooks = false

    return return_value

  end
  
  ###########################
  #  unshift_without_hooks  #
  ###########################

  ###
  # Alias to #unshift that bypasses hooks.
  #
  # @param [Object] object 
  #
  #        Object to unshift onto self.
  #
  # @return [Object] 
  #
  #         Self.
  #
  def unshift_without_hooks( *objects )

    @without_hooks = true

    unshift( *objects )
    
    @without_hooks = false
    
    return self
    
  end
  
  #######################
  #  pop_without_hooks  #
  #######################

  ###
  # Alias to #pop that bypasses hooks.
  #
  # @return [Object] 
  #
  #         Self.
  #
  def pop_without_hooks

    @without_hooks = true

    object = pop
    
    @without_hooks = false

    return object

  end
  
  #########################
  #  shift_without_hooks  #
  #########################

  ###
  # Alias to #shift that bypasses hooks.
  #
  # @return [Object] 
  #
  #         Self.
  #
  def shift_without_hooks

    @without_hooks = true

    object = shift
    
    @without_hooks = false
    
    return object
    
  end
  
  ##########################
  #  slice_without_hooks!  #
  ##########################

  ###
  # Alias to #slice! that bypasses hooks.
  #
  # @param [Integer] index_start_or_range 
  #
  #        Index at which to begin slice.
  #
  # @param [Integer] length 
  #
  #        Length of slice.
  #
  # @return [Object] 
  #
  #         Self.
  #
  def slice_without_hooks!( index_start_or_range, length = nil )

    @without_hooks = true

    slice = slice!( index_start_or_range, length )
    
    @without_hooks = false
    
    return slice
    
  end

  #########################
  #  clear_without_hooks  #
  #########################

  ###
  # Alias to #clear that bypasses hooks.
  #
  # @return [Object] 
  #
  #         Self.
  #
  def clear_without_hooks

    @without_hooks = true

    clear
    
    @without_hooks = false
    
    return self
    
  end

end
