# -*- encoding : utf-8 -*-

module ::Array::Hooked::ArrayInterface::AdditionalMethods

  ####################
  #  delete_objects  #
  ####################

  ###
  # Delete more than one object at a time.
  #
  # @overload delete_objects( object, ... )
  #
  #   @param object Object to delete.
  #
  # @return [Array<Object>] 
  #
  #         Deleted objects.
  #
  def delete_objects( *objects )

    deleted_objects = nil

    indexes = objects.collect { |this_object| index( this_object ) }
    deleted_objects = delete_at_indexes( *indexes ) unless indexes.empty?

    return deleted_objects

  end

  #######################
  #  delete_at_indexes  #
  #######################
  
  ###
  # Perform delete_at on multiple indexes.
  #
  # @overload delete_at_indexes( index, ... )
  #
  #   @param [Integer] index
  #
  #          Index that should be deleted.
  #
  # @return [Array<Object>]
  #
  #         Objects deleted.
  #
  def delete_at_indexes( *indexes )

    indexes.sort!
    indexes.uniq!

    deleted_objects = [ ]
    this_index = indexes.size - 1
    begin
      this_delete_index = indexes[ this_index ]
      this_deleted_object = delete_at( this_delete_index )
      deleted_objects.unshift( this_deleted_object )
    end while ( this_index -= 1 ) >= 0

    new_hooked_array = self.class::WithoutInternalArray.new( @configuration_instance )
    new_hooked_array.internal_array = deleted_objects
    
    return new_hooked_array

  end


  ###############################
  #  perform_get_between_hooks  #
  ###############################
  
  ###
  # Performs actual retrieval (#[]) of index between calling hooks.
  #   Separated for overriding in subclasses.
  #
  # @param [Integer] index 
  #
  #        Index where insert was requested.
  #
  # @return [Object]
  #
  #         Object at index.
  #
  def perform_get_between_hooks( *args )
    
    return undecorated_get( *args )
    
  end

  ###############################
  #  perform_set_between_hooks  #
  ###############################
  
  ###
  # Performs actual set (#[]=) at index between calling hooks.
  #   Separated for overriding in subclasses.
  #
  # @param [Integer] index 
  #
  #        Index where insert was requested.
  #
  # @param [Object] object 
  #
  #        Object to set at index.
  #
  # @return [Object]
  #
  #         Object at index.
  #
  def perform_set_between_hooks( *args )
    
    undecorated_set( *args )
    
    return true
    
  end

  ##################################
  #  perform_insert_between_hooks  #
  ##################################
  
  ###
  # Performs actual insert (#insert) at index between calling hooks.
  #   Separated for overriding in subclasses.
  #
  # @overload perform_insert_between_hooks( index, object, ... )
  #
  #   @param [Integer] index 
  #   
  #          Index where insert was requested.
  #   
  #   @param [Object] object 
  #   
  #          Object to set at index.
  #
  # @return [Object]
  #
  #         Object at index.
  #
  def perform_insert_between_hooks( index, *objects )
    
    this_index = index
    objects.each do |this_object|
      # if we get nil back that means an insert did not happen
      this_index = perform_single_object_insert_between_hooks( this_index, this_object ) ? this_index + 1 : this_index
    end
    
    return index
    
  end

  ################################################
  #  perform_single_object_insert_between_hooks  #
  ################################################
  
  ###
  # Performs actual insert (#insert) of single object at index between calling hooks.
  #   Separated for overriding in subclasses.
  #
  # @param [Integer] index 
  # 
  #        Index where insert was requested.
  # 
  # @param [Object] object 
  # 
  #        Object to set at index.
  #
  # @return [Integer]
  #
  #         Index where insert occurred.
  #
  def perform_single_object_insert_between_hooks( index, object )
    
    undecorated_insert( index, object )
    
    return index
    
  end
  
  #####################################
  #  perform_delete_at_between_hooks  #
  #####################################
  
  ###
  # Performs actual delete (#delete_at) at index between calling hooks.
  #   Separated for overriding in subclasses.
  #
  # @param [Integer] index 
  #
  #        Index where insert was requested.
  #
  # @return [Object]
  #
  #         Object deleted at index.
  #
  def perform_delete_at_between_hooks( index )

    return undecorated_delete_at( index )
    
  end
  
  ###########################
  #  filter_insert_indexes  #
  ###########################
  
  ###
  # Filter indexes provided by request for insert. Existing filtering
  #   corrects for inserts beyond the last existing index by adding nils
  #   to the objects array. Explicit nils make a number of situations easier.
  #
  # @param [Integer] index 
  #
  #        Index where insert was requested.
  #
  # @param [Array<Object>] objects 
  #
  #        Objects passed to #insert.
  #
  # @return [Integer] 
  #
  #         Resulting index from filtered modifications.
  #
  def filter_insert_indexes( index, objects )

    # if we have less elements in self than the index we are inserting at
    # we need to make sure the nils inserted cascade
    if index > size
      nils_created = index - size
      index -= nils_created
      nils_created.times { |this_time| objects.unshift( nil ) }
    elsif -index > length
      nils_created = -index - length
      index += nils_created
      nils_created.times { |this_time| objects.push( nil ) }
    end
    
    return index
    
  end

  ###########################
  #  filter_insert_objects  #
  ###########################
  
  ###
  # Filter objects provided by request for insert. 
  #
  # @param [Integer] index 
  #
  #        Index where insert was requested.
  #
  # @param [Array<Object>] objects 
  #
  #        Objects passed to #insert.
  #
  # @return [Integer] 
  #
  #         Resulting index from filtered modifications.
  #
  def filter_insert_objects( index, objects )
    
    unless @without_hooks
      this_time = -1
      length = objects.size
      objects.collect! { |this_object| pre_set_hook( this_time += 1, this_object, true, length ) }
    end

    return index
    
  end
  
end
