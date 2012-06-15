
class ::Array::Hooked < ::Array
  
  instances_identify_as!( ::Array::Hooked )
  
  ######################################  Subclass Hooks  ##########################################
  
  ##################
  #  pre_set_hook  #
  ##################

  # A hook that is called before setting a value; return value is used in place of object.
  # @param [Fixnum] index Index at which set/insert is taking place.
  # @param [Object] object Element being set/inserted.
  # @param [true,false] is_insert Whether this set is inserting a new index.
  # @return [true,false] Return value is used in place of object.
  def pre_set_hook( index, object, is_insert = false )

    return object
    
  end

  ###################
  #  post_set_hook  #
  ###################

  # A hook that is called after setting a value.
  # @param [Fixnum] index Index at which set/insert is taking place.
  # @param [Object] object Element being set/inserted.
  # @param [true,false] is_insert Whether this set is inserting a new index.
  # @return [Object] Ignored.
  def post_set_hook( index, object, is_insert = false )
    
    return object
    
  end

  ##################
  #  pre_get_hook  #
  ##################

  # A hook that is called before getting a value; if return value is false, get does not occur.
  # @param [Fixnum] index Index at which set/insert is taking place.
  # @return [true,false] If return value is false, get does not occur.
  def pre_get_hook( index )
    
    # false means get does not take place
    return true
    
  end

  ###################
  #  post_get_hook  #
  ###################

  # A hook that is called after getting a value.
  # @param [Fixnum] index Index at which get is taking place.
  # @param [Object] object Element being set/inserted.
  # @return [Object] Object returned in place of get result.
  def post_get_hook( index, object )
    
    return object
    
  end

  #####################
  #  pre_delete_hook  #
  #####################

  # A hook that is called before deleting a value; if return value is false, delete does not occur.
  # @param [Fixnum] index Index at which delete is taking place.
  # @return [true,false] If return value is false, delete does not occur.
  def pre_delete_hook( index )
    
    # false means delete does not take place
    return true
    
  end

  ######################
  #  post_delete_hook  #
  ######################

  # A hook that is called after deleting a value.
  # @param [Fixnum] index Index at which delete took place.
  # @param [Object] object Element deleted.
  # @return [Object] Object returned in place of delete result.
  def post_delete_hook( index, object )
    
    return object
    
  end
  
  #####################################  Self Management  ##########################################
  
  ########
  #  []  #
  ########

  def []( index )

    object = nil
    
    should_get = true
    
    unless @without_hooks
      should_get = pre_get_hook( index )
    end
    
    if should_get
      
      object = super( index )
    
      unless @without_hooks
        object = post_get_hook( index, object )
      end
      
    end
    
    return object
    
  end

  #######################
  #  get_without_hooks  #
  #######################

  # Alias to :[] that bypasses hooks.
  # @param [Fixnum] index Index at which set is taking place.
  # @return [Object] Element returned.
  def get_without_hooks( index )
    
    @without_hooks = true

    self[ index ] = object
    
    @without_hooks = false
    
    return object
    
  end

  ###############################
  #  perform_set_between_hooks  #
  ###############################
  
  # Alias to original :[]= method. Used to perform actual set between hooks.
  # @param [Fixnum] index Index at which set is taking place.
  # @param [Object] object Element being set.
  # @return [Object] Element returned.
  alias_method :perform_set_between_hooks, :[]=

  #########
  #  []=  #
  #########

  def []=( index, object )

    # we are either replacing or adding at the end
    # if we are replacing we are either replacing a parent element or an element in self
    # * if replacing parent element, track and exclude parent changes

    unless @without_hooks
      object = pre_set_hook( index, object, false )
    end
    
    perform_set_between_hooks( index, object )

    unless @without_hooks
      object = post_set_hook( index, object, false )
    end

    return object

  end
  
  #######################
  #  set_without_hooks  #
  #######################

  # Alias to :[]= that bypasses hooks.
  # @param [Fixnum] index Index at which set is taking place.
  # @param [Object] object Element being set.
  # @return [Object] Element returned.
  def set_without_hooks( index, object )
    
    @without_hooks = true

    self[ index ] = object
    
    @without_hooks = false
    
    return object
    
  end

  ##################################
  #  perform_insert_between_hooks  #
  ##################################

  # Alias to original :insert method. Used to perform actual insert between hooks.
  # @param [Fixnum] index Index at which insert is taking place.
  # @param [Array<Object>] objects Elements being inserted.
  # @return [Object] Element returned.
  alias_method :perform_insert_between_hooks, :insert

  ############
  #  insert  #
  ############

  def insert( index, *objects )
    
    objects_to_insert = nil
    if @without_hooks
      objects_to_insert = objects
    else
      objects_to_insert = [ ]
      objects.each_with_index do |this_object, this_index|
        this_object = pre_set_hook( index + this_index, this_object, true )
        objects_to_insert.push( this_object )
      end
    end
    objects = objects_to_insert
    
    # if we have less elements in self than the index we are inserting at
    # we need to make sure the nils inserted cascade
    if index > count
      nils_created = index - count
      index -= nils_created
      nils = [ ]
      nils_created.times do |this_time|
        nils.push( nil )
      end
      objects = nils.concat( objects )
    end

    perform_insert_between_hooks( index, *objects )

    unless @without_hooks
      objects.each_with_index do |this_object, this_index|
        objects[ this_index ] = post_set_hook( index + this_index, this_object, true )
      end
    end
        
    return objects

  end

  ##########################
  #  insert_without_hooks  #
  ##########################

  # Alias to :insert that bypasses hooks.
  # @param [Fixnum] index Index at which set is taking place.
  # @param [Array<Object>] objects Elements being inserted.
  # @return [Object] Element returned.
  def insert_without_hooks( index, *objects )

    @without_hooks = true

    super( index, *objects )
    
    @without_hooks = false

    return objects

  end
  
  ##########
  #  push  #
  ##########

  def push( *objects )

    return insert( count, *objects )

  end
  alias_method :<<, :push

  ########################
  #  push_without_hooks  #
  ########################

  # Alias to :push that bypasses hooks.
  # @param [Array<Object>] objects Elements being pushed.
  # @return [Object] Element returned.
  def push_without_hooks( *objects )

    @without_hooks = true

    push( *objects )
    
    @without_hooks = false

    return objects

  end

  ############
  #  concat  #
  ############

  def concat( *arrays )

    arrays.each do |this_array|
      push( *this_array )
    end

    return self

  end
  alias_method :+, :concat

  ##########################
  #  concat_without_hooks  #
  ##########################

  # Alias to :concat that bypasses hooks.
  # @param [Array<Object>] objects Elements being concatenated.
  # @return [Object] Element returned.
  def concat_without_hooks( *arrays )

    @without_hooks = true

    concat( *arrays )
    
    @without_hooks = false

    return arrays

  end

  ############
  #  delete  #
  ############

  def delete( object )

    return_value = nil

    if index = index( object )
      return_value = delete_at( index )
    end

    return return_value

  end

  ##########################
  #  delete_without_hooks  #
  ##########################

  # Alias to :delete that bypasses hooks.
  # @param [Object] object Element being deleted.
  # @return [Object] Element returned.
  def delete_without_hooks( object )

    @without_hooks = true

    return_value = delete( object )
    
    @without_hooks = false

    return return_value

  end

  ####################
  #  delete_objects  #
  ####################

  def delete_objects( *objects )

    return_value = nil

    indexes = [ ]
    objects.each do |this_object|
      this_index = index( this_object )
      if this_index
        indexes.push( this_index )
      end
    end

    unless indexes.empty?
      return_value = delete_at_indexes( *indexes )
    end

    return return_value

  end

  ##################################
  #  delete_objects_without_hooks  #
  ##################################

  # Alias to :delete that bypasses hooks and takes multiple objects.
  # @param [Array<Object>] objects Elements being deleted.
  # @return [Object] Element returned.
  def delete_objects_without_hooks( *objects )

    @without_hooks = true

    return_value = delete_objects( *objects )
    
    @without_hooks = false

    return return_value

  end

  #######
  #  -  #
  #######

  def -( *arrays )

    arrays.each do |this_array|
      delete_objects( *this_array )
    end

    return self

  end

  ##################################
  #  perform_delete_between_hooks  #
  ##################################

  # Alias to original :delete method. Used to perform actual delete between hooks.
  # @param [Fixnum] index Index at which delete is taking place.
  # @return [Object] Element returned.
  alias_method :perform_delete_between_hooks, :delete_at

  ###############
  #  delete_at  #
  ###############

  def delete_at( index )

    deleted_object = nil

    if @without_hooks
      pre_delete_hook_result = true
    else
      pre_delete_hook_result = pre_delete_hook( index )
    end
    
    if pre_delete_hook_result
      
      deleted_object = perform_delete_between_hooks( index )

      unless @without_hooks
        deleted_object = post_delete_hook( index, deleted_object )
      end

    end

    return deleted_object

  end

  #############################
  #  delete_at_without_hooks  #
  #############################

  # Alias to :delete_at that bypasses hooks.
  # @param [Fixnum] index Index to delete.
  # @return [Object] Deleted element.
  def delete_at_without_hooks( index )

    @without_hooks = true

    object = delete_at( index )
    
    @without_hooks = false

    return object
    
  end

  #######################
  #  delete_at_indexes  #
  #######################

  def delete_at_indexes( *indexes )

    indexes = indexes.sort.uniq.reverse

    objects = [ ]

    indexes.each do |this_index|
      objects.push( delete_at( this_index ) )
    end

    return objects

  end

  #####################################
  #  delete_at_indexes_without_hooks  #
  #####################################

  # Alias to :delete_at that bypasses hooks and takes multiple indexes.
  # @param [Array<Fixnum>] index Index to delete.
  # @return [Object] Deleted element.
  def delete_at_indexes_without_hooks( *indexes )
    
    @without_hooks = true

    objects = delete_at_indexes( *indexes )
    
    @without_hooks = false
  
    return objects
    
  end
  
  ###############
  #  delete_if  #
  ###############

  def delete_if

    return to_enum unless block_given?

    indexes = [ ]

    self.each_with_index do |this_object, index|
      if yield( this_object )
        indexes.push( index )
      end
    end

    delete_at_indexes( *indexes )

    return self

  end

  #############################
  #  delete_if_without_hooks  #
  #############################

  # Alias to :delete_if that bypasses hooks.
  # @yield Block passed to :delete_if.
  # @return [Object] Deleted element.
  def delete_if_without_hooks( & block )

    @without_hooks = true

    delete_if( & block )
    
    @without_hooks = false

    return self

  end

  #############
  #  keep_if  #
  #############

  def keep_if

    indexes = [ ]

    self.each_with_index do |this_object, index|
      unless yield( this_object )
        indexes.push( index )
      end
    end

    delete_at_indexes( *indexes )

    return self

  end

  ###########################
  #  keep_if_without_hooks  #
  ###########################

  # Alias to :keep_if that bypasses hooks.
  # @yield Block passed to :keep_if.
  # @return [Object] Deleted element.
  def keep_if_without_hooks( & block )

    @without_hooks = true

    keep_if( & block )
    
    @without_hooks = false

    return self

  end

  ##############
  #  compact!  #
  ##############

  def compact!

    return keep_if do |object|
      object != nil
    end

  end

  ############################
  #  compact_without_hooks!  #
  ############################

  # Alias to :compact that bypasses hooks.
  # @return [Object] Self.
  def compact_without_hooks!

    @without_hooks = true

    compact!
    
    @without_hooks = false

    return self

  end

  ##############
  #  flatten!  #
  ##############

  def flatten!

    return_value = nil

    indexes = [ ]

    self.each_with_index do |this_object, index|
      if this_object.is_a?( Array )
        indexes.push( index )
      end
    end

    unless indexes.empty?
      indexes.sort!.reverse!
      indexes.each do |this_index|
        this_array = delete_at( this_index )
        insert( this_index, *this_array )
      end
      return_value = self
    end

    return return_value

  end

  ############################
  #  flatten_without_hooks!  #
  ############################

  # Alias to :flatten that bypasses hooks.
  # @return [Object] Self.
  def flatten_without_hooks!

    @without_hooks = true

    return_value = flatten!
    
    @without_hooks = false

    return return_value

  end

  #############
  #  reject!  #
  #############

  def reject!

    return to_enum unless block_given?

    return_value = nil

    deleted_objects = 0

    iteration_dup = dup
    iteration_dup.each_with_index do |this_object, index|
      if yield( this_object )
        delete_at( index - deleted_objects )
        deleted_objects += 1
      end
    end

    if deleted_objects > 0
      return_value = self
    end

    return return_value

  end

  ###########################
  #  reject_without_hooks!  #
  ###########################

  # Alias to :reject that bypasses hooks.
  # @yield Block passed to :keep_if.
  # @return [Object] Self.
  def reject_without_hooks!( & block )

    @without_hooks = true

    reject!( & block )
    
    @without_hooks = false

    return return_value

  end

  #############
  #  replace  #
  #############

  def replace( other_array )

    clear

    other_array.each_with_index do |this_object, index|
      unless self[ index ] == this_object
        self[ index ] = this_object
      end
    end

    return self

  end

  ###########################
  #  replace_without_hooks  #
  ###########################

  # Alias to :replace that bypasses hooks.
  # @param [Array] other_array Other array to replace self with.
  # @return [Object] Self.
  def replace_without_hooks( other_array )
    
    @without_hooks = true

    replace( other_array )
    
    @without_hooks = false
    
    return self
    
  end
  
  ##############
  #  reverse!  #
  ##############

  def reverse!

    reversed_array = reverse

    clear

    reversed_array.each_with_index do |this_object, index|
      self[ index ] = this_object
    end

    return self

  end

  ############################
  #  reverse_without_hooks!  #
  ############################

  # Alias to :reverse that bypasses hooks.
  # @return [Object] Self.
  def reverse_without_hooks!

    @without_hooks = true

    reverse!
    
    @without_hooks = false

    return self

  end
  
  #############
  #  rotate!  #
  #############

  def rotate!( rotate_count = 1 )

    reversed_array = rotate( rotate_count )

    clear

    reversed_array.each_with_index do |this_object, index|
      self[ index ] = this_object
    end

    return self

  end

  ###########################
  #  rotate_without_hooks!  #
  ###########################

  # Alias to :rotate that bypasses hooks.
  # @param [Fixnum] rotate_count Integer count of how many elements to rotate.
  # @return [Object] Self.
  def rotate_without_hooks!( rotate_count = 1 )

    @without_hooks = true

    rotate!( rotate_count )
    
    @without_hooks = false

    return self

  end
  
  #############
  #  select!  #
  #############

  def select!

    return to_enum unless block_given?

    deleted_objects = 0

    iteration_dup = dup
    iteration_dup.each_with_index do |this_object, index|
      unless yield( this_object )
        delete_at( index - deleted_objects )
        deleted_objects += 1
      end
    end

    return self

  end

  ###########################
  #  select_without_hooks!  #
  ###########################

  # Alias to :select that bypasses hooks.
  # @yield Block passed to :select!.
  # @return [Object] Self.
  def select_without_hooks!( & block )
  
    @without_hooks = true

    select!( & block )
    
    @without_hooks = false
  
    return self
  
  end
  
  ##############
  #  shuffle!  #
  ##############

  def shuffle!( random_number_generator = nil )

    shuffled_array = shuffle( random: random_number_generator )

    clear

    shuffled_array.each_with_index do |this_object, index|
      self[ index ] = this_object
    end

    return self

  end
  
  ############################
  #  shuffle_without_hooks!  #
  ############################

  # Alias to :shuffle that bypasses hooks.
  # @param [Object] random_number_generator Random number generator passed to :shuffle!.
  # @return [Object] Self.
  def shuffle_without_hooks!( random_number_generator = nil )

    @without_hooks = true

    shuffle!( random_number_generator )
    
    @without_hooks = false

    return self

  end

  ##############
  #  collect!  #
  #  map!      #
  ##############

  def collect!

    return to_enum unless block_given?

    self.each_with_index do |this_object, index|
      replacement_object = yield( this_object )
      self[ index ] = replacement_object
    end

    return self

  end
  alias_method :map!, :collect!

  ############################
  #  collect_without_hooks!  #
  #  map_without_hooks!      #
  ############################

  # Alias to :select that bypasses hooks.
  # @yield Block passed to :collect!.
  # @return [Object] Self.
  def collect_without_hooks!( & block )
    
    @without_hooks = true

    collect!( & block )
    
    @without_hooks = false
    
    return self
    
  end
  alias_method :map_without_hooks!, :collect_without_hooks!
  
  ###########
  #  sort!  #
  ###########

  def sort!( & block )

    sorted_array = sort( & block )

    unless sorted_array == self

      replace( sorted_array )

    end

    return self

  end

  #########################
  #  sort_without_hooks!  #
  #########################

  # Alias to :sort that bypasses hooks.
  # @yield Block passed to :sort!.
  # @return [Object] Self.
  def sort_without_hooks!( & block )
    
    @without_hooks = true

    sort!
    
    @without_hooks = false
    
    return self
    
  end
  
  ##############
  #  sort_by!  #
  ##############

  def sort_by!( & block )

    return to_enum unless block_given?

    sorted_array = sort_by( & block )

    unless sorted_array == self

      replace( sorted_array )

    end

    return self

  end

  ############################
  #  sort_by_without_hooks!  #
  ############################

  # Alias to :sort_by! that bypasses hooks.
  # @yield Block passed to :sort_by!.
  # @return [Object] Self.
  def sort_by_without_hooks!( & block )
    
    @without_hooks = true

    sort_by!( & block )
    
    @without_hooks = false
    
    return self
    
  end
  
  ###########
  #  uniq!  #
  ###########

  def uniq!

    return_value = nil

    uniq_array = uniq

    unless uniq_array == self

      clear

      replace( uniq_array )

    end

    return return_value

  end

  #########################
  #  uniq_without_hooks!  #
  #########################

  # Alias to :uniq! that bypasses hooks.
  # @return [Object] Self.
  def uniq_without_hooks!

    @without_hooks = true

    return_value = uniq!
    
    @without_hooks = false

    return return_value

  end
  
  #############
  #  unshift  #
  #############

  def unshift( object )

    insert( 0, object )

    return self

  end

  ###########################
  #  unshift_without_hooks  #
  ###########################

  # Alias to :unshift that bypasses hooks.
  # @param [Object] object Object to unshift onto self.
  # @return [Object] Self.
  def unshift_without_hooks( object )

    @without_hooks = true

    unshift( object )
    
    @without_hooks = false
    
    return self
    
  end
  
  #########
  #  pop  #
  #########

  def pop

    object = delete_at( count - 1 )

    return object

  end

  #######################
  #  pop_without_hooks  #
  #######################

  # Alias to :pop that bypasses hooks.
  # @return [Object] Self.
  def pop_without_hooks

    @without_hooks = true

    object = pop
    
    @without_hooks = false

    return object

  end
  
  ###########
  #  shift  #
  ###########

  def shift

    object = delete_at( 0 )

    return object

  end

  #########################
  #  shift_without_hooks  #
  #########################

  # Alias to :shift that bypasses hooks.
  # @return [Object] Self.
  def shift_without_hooks

    @without_hooks = true

    object = shift
    
    @without_hooks = false
    
    return object
    
  end
  
  ############
  #  slice!  #
  ############

  def slice!( index_start_or_range, length = nil )

    slice = nil

    start_index = nil
    end_index = nil

    if index_start_or_range.is_a?( Range )

      start_index = index_start_or_range.begin
      end_index = index_start_or_range.end

    elsif length

      start_index = index_start_or_range
      end_index = index_start_or_range + length

    end

    if end_index

      indexes = [ ]

      ( end_index - start_index ).times do |this_time|
        indexes.push( end_index - this_time - 1 )
      end

      slice = delete_at_indexes( *indexes )

    else

      slice = delete_at( start_index )

    end


    return slice

  end

  ##########################
  #  slice_without_hooks!  #
  ##########################

  # Alias to :slice! that bypasses hooks.
  # @param [Fixnum] index_start_or_range Index at which to begin slice.
  # @param [Fixnum] length Length of slice.
  # @return [Object] Self.
  def slice_without_hooks!( index_start_or_range, length = nil )

    @without_hooks = true

    slice = slice!( index_start_or_range, length )
    
    @without_hooks = false
    
    return slice
    
  end
  
  ###########
  #  clear  #
  ###########

  def clear

    indexes = [ ]

    count.times do |this_time|
      indexes.push( count - this_time - 1 )
    end

    delete_at_indexes( *indexes )

    return self

  end

  #########################
  #  clear_without_hooks  #
  #########################

  # Alias to :clear that bypasses hooks.
  # @return [Object] Self.
  def clear_without_hooks

    @without_hooks = true

    clear
    
    @without_hooks = false
    
    return self
    
  end

end
