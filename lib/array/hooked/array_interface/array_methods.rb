
module ::Array::Hooked::ArrayInterface::ArrayMethods
  
  ########
  #  ==  #
  ########
  
  ###
  # Equality—Two arrays are equal if they contain the same number of elements and if each 
  #   element is equal to (according to Object.==) the corresponding element in the other array.
  # 
  def ==( other_array )
    
    return @internal_array == other_array

  end

  #########
  #  <=>  #
  #########
  
  ###
  # Comparison—Returns an integer (-1, 0, or +1) if this array is less than, equal to, or 
  #   greater than other_ary. Each object in each array is compared (using <=>). If any value 
  #   isn’t equal, then that inequality is the return value. If all the values found are equal, 
  #   then the return is based on a comparison of the array lengths. Thus, two arrays are 
  #   “equal” according to Array#<=> if and only if they have the same length and the value of 
  #   each element is equal to the value of the corresponding element in the other array.
  #
  def <=>( other_array )
    
    return @internal_array <=> other_array
    
  end
  
  #######
  #  +  #
  #######

  ###
  # Concatenation—Returns a new array built by concatenating the two arrays together 
  #   to produce a third array.
  #
  def +( array )

    result_array = dup
    result_array.push( *array )

    return result_array

  end
  
  #######
  #  -  #
  #######

  ###
  # Array Difference—Returns a new array that is a copy of the original array, removing 
  #   any items that also appear in other_ary.
  #
  def -( array )
    
    result_array = dup
    result_array.delete_objects( *array )

    return result_array

  end

  #######
  #  *  #
  #######
  
  ###
  # Repetition—With a String argument, equivalent to self.join(str). Otherwise, returns a 
  #   new array built by concatenating the int copies of self.
  #
  # @overload *( integer )
  #
  # @overload *( string )
  #
  def *( integer_or_string )

    result_array = dup
    result_array.internal_array *= integer_or_string
    
    return result_array
    
  end

  #######
  #  &  #
  #######
  
  ###
  # Set Intersection—Returns a new array containing elements common to the two arrays, 
  #   with no duplicates.
  #
  def &( other_array )
    
    result_array = dup
    result_array.internal_array &= other_array
    
    return result_array
    
  end

  #######
  #  |  #
  #######
  
  ###
  # Set Union—Returns a new array by joining this array with other_ary, removing duplicates.
  #
  def |( other_array )
    
    result_array = dup
    result_array.internal_array |= other_array
    
    return result_array
    
  end

  ########
  #  <<  #
  ########
  
  ###
  # Append—Pushes the given object on to the end of this array. This expression returns the array 
  #   itself, so several appends may be chained together.
  #
  def <<( object )

    insert( length, object )
    
    return self

  end

  ########
  #  []  #
  ########

  ###
  # Element Reference—Returns the element at index, or returns a subarray starting 
  #   at start and continuing for length elements, or returns a subarray specified 
  #   by range. Negative indices count backward from the end of the array (-1 is 
  #   the last element). Returns nil if the index (or starting index) are out of range.
  #
  # @overload []( index )
  #
  # @overload []( start, length )
  #
  # @overload []( range )
  #
  def []( index )

    object = nil
    
    should_get = true
    
    unless @without_hooks
      should_get = pre_get_hook( index )
    end
    
    if should_get
      
      object = perform_get_between_hooks( index )
    
      unless @without_hooks
        object = post_get_hook( index, object )
      end
      
    end
    
    return object
    
  end

  #########
  #  []=  #
  #########

  ###
  # Element Assignment—Sets the element at index, or replaces a subarray starting at 
  #   start and continuing for length elements, or replaces a subarray specified by 
  #   range. If indices are greater than the current capacity of the array, the array 
  #   grows automatically. A negative indices will count backward from the end of the 
  #   array. Inserts elements if length is zero. An IndexError is raised if a negative 
  #   index points past the beginning of the array. See also Array#push, and Array#unshift.
  #
  # @overload array[ index ] = object
  #
  # @overload array[ start, length ] = object
  #
  # @overload array[ range ] = object
  #
  # @overload array[ range ] = other_array
  #
  def []=( index, object )

    unless @without_hooks
      object = pre_set_hook( index, object, false )
    end
    
    perform_set_between_hooks( index, object )

    unless @without_hooks
      object = post_set_hook( index, object, false )
    end

    return object

  end

  ################
  #  hooked_set  #
  ################
  
  ###
  # 
  #
  alias_method :hooked_set, :[]=
  
  ###########
  #  assoc  #
  ###########
  
  ###
  # Searches through an array whose elements are also arrays comparing obj with the first 
  #   element of each contained array using obj.==. Returns the first contained array 
  #   that matches (that is, the first associated array), or nil if no match is found. 
  #   
  #   See also Array#rassoc.
  #
  def assoc( object )

    return @internal_array.assoc( object )

  end

  ########
  #  at  #
  ########
  
  ###
  # Returns the element at index. A negative index counts from the end of self. 
  #   Returns nil if the index is out of range. See also Array#[].
  #
  alias_method( :at, :[] )

  ###########
  #  clear  #
  ###########

  ###
  # Removes all elements from self.
  #
  def clear

    delete_if { true }

    return self

  end  

  #############
  #  collect  #
  #############
  
  ###
  # Invokes block once for each element of self. Creates a new array containing the values 
  #   returned by the block. See also Enumerable#collect.
  #   If no block is given, an enumerator is returned instead.
  #
  def collect

    return dup.collect!

  end

  ##############
  #  collect!  #
  ##############

  ###
  # Invokes the block once for each element of self, replacing the element with the value 
  #   returned by block. See also Enumerable#collect.
  #   If no block is given, an enumerator is returned instead.
  #
  def collect!

    return to_enum unless block_given?

    self.each_with_index do |this_object, index|
      replacement_object = yield( this_object )
      self[ index ] = replacement_object
    end

    return self

  end

  #################
  #  combination  #
  #################
  
  ###
  # When invoked with a block, yields all combinations of length n of elements from ary and 
  #   then returns ary itself. The implementation makes no guarantees about the order in 
  #   which the combinations are yielded.
  #   If no block is given, an enumerator is returned instead.
  #
  def combination( number, & block )
    
    return_value = self
    
    if block_given?
      @internal_array.combination( & block )
    else
      return_value = to_enum( __method__ )
    end
    
    return return_value

  end

  #############
  #  compact  #
  #############
  
  ###
  # Returns a copy of self with all nil elements removed.
  #
  def compact
    
    return dup.compact!
    
  end

  ##############
  #  compact!  #
  ##############

  ###
  # Removes nil elements from the array. Returns nil if no changes were made, otherwise returns ary.
  #
  def compact!

    return keep_if do |object|
      object != nil
    end

  end

  ############
  #  concat  #
  ############

  ###
  # Appends the elements of other_ary to self.
  #
  def concat( *arrays )
    
    arrays.each do |this_array|
      push( *this_array )
    end

    return self
    
  end

  ###########
  #  count  #
  ###########
  
  ###
  # Returns the number of elements. If an argument is given, counts the number of elements 
  #   which equals to obj. If a block is given, counts the number of elements yielding a 
  #   true value.
  #
  def count( object = nil, & block )
    
    return @internal_array.count( object, & block )
    
  end

  ###########
  #  cycle  #
  ###########
  
  ###
  # Calls block for each element repeatedly n times or forever if none or nil is given. 
  #   If a non-positive number is given or the array is empty, does nothing. 
  #   Returns nil if the loop has finished without getting interrupted.
  #   If no block is given, an enumerator is returned instead.
  #
  def cycle( number, & block )
    
    return_value = self
    
    if block_given?
      @internal_array.cycle( number, & block )
    else
      return_value = to_enum( __method__ )
    end
    
    return return_value
    
  end

  ############
  #  delete  #
  ############

  ###
  # Deletes items from self that are equal to obj. If any items are found, returns obj. 
  #   If the item is not found, returns nil. If the optional code block is given, returns 
  #   the result of block if the item is not found. (To remove nil elements and get an 
  #   informative return value, use compact!)
  #
  def delete( object )

    return_value = nil

    if index = index( object )
      return_value = delete_at( index )
    end

    return return_value

  end

  ###################
  #  hooked_delete  #
  ###################
  
  ###
  # 
  #
  alias_method :hooked_delete, :delete

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

  ###############
  #  delete_at  #
  ###############

  ###
  # Deletes the element at the specified index, returning that element, or nil if 
  #   the index is out of range. See also Array#slice!.
  #
  def delete_at( index )

    deleted_object = nil

    if @without_hooks
      pre_delete_hook_result = true
    else
      pre_delete_hook_result = pre_delete_hook( index )
    end
    
    if pre_delete_hook_result
      
      deleted_object = perform_delete_at_between_hooks( index )

      unless @without_hooks
        deleted_object = post_delete_hook( index, deleted_object )
      end

    end

    return deleted_object

  end
  
  ######################
  #  hooked_delete_at  #
  ######################

  ###
  # 
  #
  alias_method :hooked_delete_at, :delete_at

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

    indexes = indexes.sort.uniq.reverse

    objects = [ ]

    indexes.each do |this_index|
      objects.push( delete_at( this_index ) )
    end

    return objects

  end

  ###############
  #  delete_if  #
  ###############

  ###
  # Deletes every element of self for which block evaluates to true. The array is 
  #   changed instantly every time the block is called and not after the iteration 
  #   is over. See also Array#reject!
  #   If no block is given, an enumerator is returned instead.
  #
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

  ##########
  #  drop  #
  ##########
  
  ###
  # Drops first n elements from ary and returns the rest of the elements in an array.
  #
  def drop( number )
    
    result_array = dup
    result_array.internal_array.drop( number )
    
    return result_array
    
  end

  ################
  #  drop_while  #
  ################
  
  ###
  # Drops elements up to, but not including, the first element for which the block returns 
  #   nil or false and returns an array containing the remaining elements.
  #   If no block is given, an enumerator is returned instead.
  #
  def drop_while( & block )

    return_value = self
    
    if block_given?
      @internal_array.drop_while( & block )
    else
      return_value = to_enum( __method__ )
    end
    
    return return_value

  end

  ##########
  #  each  #
  ##########
  
  ###
  # Calls block once for each element in self, passing that element as a parameter.
  #   If no block is given, an enumerator is returned instead. 
  #
  def each( & block )

    return_value = self
    
    if block_given?
      @internal_array.each( & block )
    else
      return_value = to_enum( __method__ )
    end
    
    return return_value

  end

  ################
  #  each_index  #
  ################
  
  ###
  # Same as Array#each, but passes the index of the element instead of the element itself.
  #  If no block is given, an enumerator is returned instead.
  #
  def each_index

    return_value = self
    
    if block_given?
      @internal_array.each_index( & block )
    else
      return_value = to_enum( __method__ )
    end
    
    return return_value

  end

  ############
  #  empty?  #
  ############
  
  ###
  # Returns true if self contains no elements.
  #
  def empty?
    
    return @internal_array.empty?
    
  end
  
  ##########
  #  eql?  #
  ##########
  
  ###
  # Returns true if self and other are the same object, or are both arrays with the same content.
  #
  def eql?( other_object )
   
   return super || @internal_array.eql?( other_object )
    
  end

  ###########
  #  fetch  #
  ###########
  
  ###
  # Tries to return the element at position index. If the index lies outside the array, the first 
  #   form throws an IndexError exception, the second form returns default, and the third form 
  #   returns the value of invoking the block, passing in the index. Negative values of index 
  #   count from the end of the array.
  #
  def fetch( index, default = nil, & block )
    
    return @internal_array.fetch( index, default, & block )
    
  end

  ##########
  #  fill  #
  ##########
  
  ###
  # The first three forms set the selected elements of self (which may be the entire array) to obj. 
  #   A start of nil is equivalent to zero. A length of nil is equivalent to self.length. The last 
  #   three forms fill the array with the value of the block. The block is passed the absolute index 
  #   of each element to be filled. Negative values of start count from the end of the array.
  #
  def fill( *args, & block )
    
    @internal_array.fill( *args, & block )
    
    return self
    
  end

  ################
  #  find_index  #
  ################
  
  ###
  # Returns the index of the first object in self such that the object is == to obj. If a block is 
  #   given instead of an argument, returns index of first object for which block is true. 
  #   Returns nil if no match is found. See also Array#rindex.
  #   If neither block nor argument is given, an enumerator is returned instead.
  #
  def find_index( object = nil, & block )
    
    return @internal_array.find_index( object, & block )
    
  end

  ###########
  #  index  #
  ###########
  
  ###
  # Returns the index of the first object in self such that the object is == to obj. 
  #   If a block is given instead of an argument, returns index of first object for which block is true. 
  #   Returns nil if no match is found. See also Array#rindex.
  #   If neither block nor argument is given, an enumerator is returned instead.
  #
  #   This is an alias of #find_index.
  #
  alias_method :index, :find_index

  ###########
  #  first  #
  ###########
  
  ###
  # Returns the first element, or the first n elements, of the array. If the array is empty, the first 
  #   form returns nil, and the second form returns an empty array.
  #
  def first
    
    return self[ 0 ]
    
  end

  #############
  #  flatten  #
  #############
  
  ###
  # Returns a new array that is a one-dimensional flattening of this array (recursively). That is, 
  #   for every element that is an array, extract its elements into the new array. 
  #   If the optional level argument determines the level of recursion to flatten.
  #
  def flatten
    
    return dup.flatten!
    
  end

  ##############
  #  flatten!  #
  ##############

  ###
  # Flattens self in place. Returns nil if no modifications were made (i.e., ary contains no 
  #   subarrays.) If the optional level argument determines the level of recursion to flatten.
  #
  def flatten!

    return_value = nil

    indexes = [ ]

    self.each_with_index do |this_object, this_index|
      if this_object.is_a?( ::Array )
        indexes.push( this_index )
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

  ############
  #  freeze  #
  ############
  
  ###
  # Prevents further modifications to obj. A RuntimeError will be raised if modification is attempted. 
  #   There is no way to unfreeze a frozen object. See also Object#frozen?.
  #   This method returns self.
  #
  def freeze
    
    @internal_array.freeze
    
    return self
    
  end

  ##########
  #  hash  #
  ##########
  
  ###
  # Compute a hash-code for this array. Two arrays with the same content will have the same hash 
  #   code (and will compare using eql?).
  #
  def hash
    
    return @internal_array.hash
    
  end

  ##############
  #  include?  #
  ##############
  
  ###
  # Returns true if the given object is present in self (that is, if any object == anObject), 
  #   false otherwise.
  #
  def include?( object )
    
    return @internal_array.include?( object )
    
  end

  #############
  #  inspect  #
  #############
  
  ###
  # Creates a string representation of self.
  # 
  #   Also aliased as: #to_s.
  #
  def inspect
    
    return @internal_array.to_s
    
  end

  ##########
  #  join  #
  ##########
  
  ###
  # Returns a string created by converting each element of the array to a string, separated by sep.
  #
  def join( separator = $, )
    
    return @internal_array.join( separator )
    
  end

  #############
  #  keep_if  #
  #############

  ###
  # Deletes every element of self for which block evaluates to false. See also Array#select!
  #   If no block is given, an enumerator is returned instead.
  #
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

  ##########
  #  last  #
  ##########
  
  ###
  # Returns the last element(s) of self. If the array is empty, the first form returns nil.
  #
  def last
    
    return self[ -1 ]
    
  end

  ############
  #  length  #
  ############
  
  ###
  # Returns the number of elements in self. May be zero.
  #
  #   Also aliased as: size.
  #
  def length
    
    return @internal_array.length
    
  end

  #########
  #  map  #
  #########
  
  ###
  # Invokes block once for each element of self. Creates a new array containing the values returned 
  #   by the block. See also Enumerable#collect.
  #   If no block is given, an enumerator is returned instead.
  #
  alias_method :map, :collect

  ##########
  #  map!  #
  ##########
  
  ###
  # Invokes the block once for each element of self, replacing the element with the value returned 
  #   by block. See also Enumerable#collect.
  #   If no block is given, an enumerator is returned instead.
  #
  alias_method :map!, :collect!

  ##########
  #  pack  #
  ##########
  
  ###
  # Packs the contents of arr into a binary sequence according to the directives in aTemplateString 
  #   (see the table below) Directives “A,” “a,” and “Z” may be followed by a count, which gives the 
  #   width of the resulting field. The remaining directives also may take a count, indicating the 
  #   number of array elements to convert. If the count is an asterisk (“*”), all remaining array 
  #   elements will be converted. Any of the directives “sSiIlL” may be followed by an underscore (“_”) 
  #   or exclamation mark (“!”) to use the underlying platform’s native size for the specified type; 
  #   otherwise, they use a platform-independent size. Spaces are ignored in the template string. 
  #   See also String#unpack.
  #
  def pack( template_string )
    
    return @internal_array.pack( template_string )
    
  end

  #################
  #  permutation  #
  #################
  
  ###
  # When invoked with a block, yield all permutations of length n of the elements of ary, then 
  #   return the array itself. If n is not specified, yield all permutations of all elements. 
  #   The implementation makes no guarantees about the order in which the permutations are yielded.
  #   If no block is given, an enumerator is returned instead.
  #
  def permutation( number = nil, & block )
    
    return_value = self
    
    if block_given?
      @internal_array.permutation( number, & block )
    else
      return_value = to_enum( __method__ )
    end
    
    return return_value

  end

  #########
  #  pop  #
  #########

  ###
  # Removes the last element from self and returns it, or nil if the array is empty.
  #   If a number n is given, returns an array of the last n elements (or less) 
  #   just like array.slice!(-n, n) does.
  #
  def pop

    object = delete_at( count - 1 )

    return object

  end

  #############
  #  product  #
  #############
  
  ###
  # Returns an array of all combinations of elements from all arrays. The length of the 
  #   returned array is the product of the length of self and the argument arrays. 
  #   If given a block, product will yield all combinations and return self instead.
  #
  def product( *other_arrays, & block )
    
    return @internal_array.product( * other_arrays, & block )
    
  end

  ##########
  #  push  #
  ##########

  ###
  # Append—Pushes the given object(s) on to the end of this array. This expression returns 
  #   the array itself, so several appends may be chained together.
  #
  def push( *objects )
    
    return insert( length, *objects )
    
  end

  ############
  #  rassoc  #
  ############
  
  ###
  # Searches through the array whose elements are also arrays. Compares obj with the second 
  #   element of each contained array using ==. Returns the first contained array that matches. 
  #   See also Array#assoc.
  #
  def rassoc( object )
    
    return @internal_array.rassoc( object )
    
  end

  ############
  #  reject  #
  ############
  
  ###
  # Returns a new array containing the items in self for which the block is not true. 
  #   See also Array#delete_if
  #   If no block is given, an enumerator is returned instead.
  #
  def reject( & block )
    
    return dup.reject!( & block )
    
  end

  #############
  #  reject!  #
  #############

  ###
  # Equivalent to Array#delete_if, deleting elements from self for which the block evaluates to true, 
  #   but returns nil if no changes were made. The array is changed instantly every time the block 
  #   is called and not after the iteration is over. See also Enumerable#reject and Array#delete_if.
  #   If no block is given, an enumerator is returned instead.
  #
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

  ##########################
  #  repeated_combination  #
  ##########################
  
  ###
  # When invoked with a block, yields all repeated combinations of length n of elements from ary 
  #   and then returns ary itself. The implementation makes no guarantees about the order in which 
  #   the repeated combinations are yielded.
  #   If no block is given, an enumerator is returned instead.
  #
  def repeated_combination( number, & block )

    return_value = self
    
    if block_given?
      @internal_array.repeated_combination( number, & block )
    else
      return_value = to_enum( __method__ )
    end
    
    return return_value

  end

  ##########################
  #  repeated_permutation  #
  ##########################
  
  ###
  # When invoked with a block, yield all repeated permutations of length n of the elements of ary, 
  #   then return the array itself. The implementation makes no guarantees about the order in which 
  #   the repeated permutations are yielded.
  #   If no block is given, an enumerator is returned instead.
  #
  def repeated_permutation( number, & block )

    return_value = self
    
    if block_given?
      @internal_array.repeated_permutation( number, & block )
    else
      return_value = to_enum( __method__ )
    end
    
    return return_value

  end

  #############
  #  replace  #
  #############

  ###
  # Replaces the contents of self with the contents of other_ary, truncating or expanding if necessary.
  #
  def replace( other_array )

    clear

    other_array.each_with_index do |this_object, index|
      unless self[ index ] == this_object
        self[ index ] = this_object
      end
    end

    return self

  end

  ############
  #  insert  #
  ############

  ###
  # Inserts the given values before the element with the given index (which may be negative).
  #
  def insert( index, *objects )

    index = filter_insert_objects( index, objects )

    unless @without_hooks
      objects.each_with_index do |this_object, this_index|
        this_object = pre_set_hook( index + this_index, this_object, true )
        objects[ this_index ] = this_object
      end
    end

    perform_insert_between_hooks( index, *objects )

    unless @without_hooks
      objects.each_with_index do |this_object, this_index|
        objects[ this_index ] = post_set_hook( index + this_index, this_object, true )
      end
    end

    return objects

  end
  
  ###################
  #  hooked_insert  #
  ###################
  
  ###
  # 
  #
  alias_method :hooked_insert, :insert

  #############
  #  reverse  #
  #############
  
  ###
  # Returns a new array containing self‘s elements in reverse order.
  #
  def reverse

    return dup.reverse!

  end
  
  ##############
  #  reverse!  #
  ##############

  ###
  # Reverses self in place.
  #
  def reverse!

    @internal_array.reverse!

    return self

  end

  ##################
  #  reverse_each  #
  ##################
  
  ###
  # Same as Array#each, but traverses self in reverse order.
  #
  def reverse_each
    
    return_value = self
    
    if block_given?
      @internal_array.reverse_each( & block )
    else
      return_value = to_enum( __method__ )
    end
    
    return return_value
    
  end

  ############
  #  rindex  #
  ############
  
  ###
  # Returns the index of the last object in self == to obj. If a block is given instead of an argument, 
  #   returns index of first object for which block is true, starting from the last object. Returns nil 
  #   if no match is found. See also Array#index.
  #   If neither block nor argument is given, an enumerator is returned instead.
  #
  def rindex( object = nil, & block )

    return_value = self
    
    if block_given?
      @internal_array.rindex( object, & block )
    else
      return_value = to_enum( __method__ )
    end
    
    return return_value

  end

  ############
  #  rotate  #
  ############
  
  ###
  # Returns new array by rotating self so that the element at cnt in self is the first element of the 
  #   new array. If cnt is negative then it rotates in the opposite direction.
  #
  def rotate( count = 1 )
    
    return dup.rotate!( count )
    
  end

  #############
  #  rotate!  #
  #############

  ###
  # Rotates self in place so that the element at cnt comes first, and returns self. If cnt is negative 
  #   then it rotates in the opposite direction.
  #
  def rotate!( rotate_count = 1 )

    @internal_array.rotate!( rotate_count )

    return self

  end
  
  ############
  #  sample  #
  ############
  
  ###
  # Choose a random element or n random elements from the array. The elements are chosen by using 
  #   random and unique indices into the array in order to ensure that an element doesn’t repeat 
  #   itself unless the array already contained duplicate elements. If the array is empty the first 
  #   form returns nil and the second form returns an empty array.
  #   If rng is given, it will be used as the random number generator.
  #
  def sample( *args )
    
    return @internal_array.sample( *args )
    
  end

  ############
  #  select  #
  ############
  
  ###
  # Invokes the block passing in successive elements from self, returning an array containing those 
  #   elements for which the block returns a true value (equivalent to Enumerable#select).
  #   If no block is given, an enumerator is returned instead.
  #
  def select
    
    return dup.select!
    
  end

  #############
  #  select!  #
  #############

  ###
  # Invokes the block passing in successive elements from self, deleting elements for which the block 
  #   returns a false value. It returns self if changes were made, otherwise it returns nil. 
  #   See also Array#keep_if
  #   If no block is given, an enumerator is returned instead.
  #
  def select!

    return to_enum unless block_given?

    deleted_objects = 0

    dup.each_with_index do |this_object, index|
      unless yield( this_object )
        delete_at( index - deleted_objects )
        deleted_objects += 1
      end
    end

    return self

  end

  ###########
  #  shift  #
  ###########

  ###
  # Returns the first element of self and removes it (shifting all other elements down by one). 
  #   Returns nil if the array is empty.
  #   If a number n is given, returns an array of the first n elements (or less) just like 
  #   array.slice!(0, n) does.
  #
  def shift

    object = delete_at( 0 )

    return object

  end

  #############
  #  shuffle  #
  #############
  
  ###
  # Returns a new array with elements of this array shuffled.
  #   If rng is given, it will be used as the random number generator.
  #
  def shuffle( random_number_generator = nil )
    
    return dup.shuffle!( random_number_generator )
    
  end

  ##############
  #  shuffle!  #
  ##############

  ###
  # Shuffles elements in self in place. If rng is given, it will be used as the random number generator.
  #
  def shuffle!( random_number_generator = nil )

    @internal_array.shuffle!( random: random_number_generator )

    return self

  end

  ##########
  #  size  #
  ##########
  
  ###
  # Alias for length.
  #
  alias_method :size, :length

  ###########
  #  slice  #
  ###########
  
  ###
  # Element Reference—Returns the element at index, or returns a subarray starting at start and 
  #   continuing for length elements, or returns a subarray specified by range. Negative indices 
  #   count backward from the end of the array (-1 is the last element). Returns nil if the index 
  #   (or starting index) are out of range.
  #
  def slice( *args )
    
    return dup.slice!( *args )
    
  end

  ############
  #  slice!  #
  ############

  ###
  # Deletes the element(s) given by an index (optionally with a length) or by a range. 
  #   Returns the deleted object (or objects), or nil if the index is out of range.
  #
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
  
  ##########
  #  sort  #
  ##########
  
  ###
  # Returns a new array created by sorting self. Comparisons for the sort will be done using 
  #   the <=> operator or using an optional code block. The block implements a comparison between 
  #   a and b, returning -1, 0, or +1. See also Enumerable#sort_by.
  #
  def sort( & block )
    
    return dup.sort!( & block )
    
  end

  ###########
  #  sort!  #
  ###########

  ###
  # Sorts self. Comparisons for the sort will be done using the <=> operator or using an optional 
  #   code block. The block implements a comparison between a and b, returning -1, 0, or +1. 
  #   See also Enumerable#sort_by.
  #
  def sort!( & block )

    @internal_array.sort!( & block )

    return self

  end

  ##############
  #  sort_by!  #
  ##############

  ###
  # Sorts self in place using a set of keys generated by mapping the values in self through 
  #   the given block.
  #   If no block is given, an enumerator is returned instead.
  #
  def sort_by!( & block )

    return to_enum unless block_given?

    sorted_array = sort_by( & block )

    unless sorted_array == self
      replace( sorted_array )
    end

    return self

  end

  ##########
  #  take  #
  ##########
  
  ###
  # Returns first n elements from ary.
  #
  def take( number )
    
    return slice( 0, number - 1 )
    
  end

  ################
  #  take_while  #
  ################
  
  ###
  # Passes elements to the block until the block returns nil or false, then stops iterating 
  #   and returns an array of all prior elements.
  #   If no block is given, an enumerator is returned instead.
  #
  def take_while( & block )
    
    return_value = self
    
    if block_given?
      @internal_array.take_while( & block )
    else
      return_value = to_enum( __method__ )
    end
    
    return return_value
    
  end

  ##########
  #  to_a  #
  ##########
  
  ###
  # Returns self.
  #
  def to_a
    
    return self
    
  end

  ############
  #  to_ary  #
  ############
  
  ###
  # Returns self.
  #
  def to_ary
    
    return self
    
  end

  ##########
  #  to_s  #
  ##########
  
  ###
  # Alias for inspect.
  #
  alias_method :to_s, :inspect
  
  ###############
  #  transpose  #
  ###############
  
  ###
  # Assumes that self is an array of arrays and transposes the rows and columns.
  #
  def transpose
    
    result_array = dup
    result_array.internal_array.transpose( other_array )
    
    return result_array
    
  end

  ##########
  #  uniq  #
  ##########
  
  ###
  # Returns a new array by removing duplicate values in self. If a block is given, it will use the 
  #   return value of the block for comparison.
  #
  def uniq( & block )
    
    return dup.uniq!( & block )
    
  end

  ###########
  #  uniq!  #
  ###########

  ###
  # Removes duplicate elements from self. If a block is given, it will use the return value of the 
  #   block for comparison. Returns nil if no changes are made (that is, no duplicates are found).
  #
  def uniq!

    @internal_array.uniq!

    return self

  end

  #############
  #  unshift  #
  #############

  ###
  # Prepends objects to the front of self, moving other elements upwards.
  #
  def unshift( object )

    insert( 0, object )

    return self

  end

  ###############
  #  values_at  #
  ###############
  
  ###
  # Returns an array containing the elements in self corresponding to the given selector(s). 
  #   The selectors may be either integer indices or ranges. See also Array#select.
  #
  def values_at( *selectors )
    
    result_array = self.class::WithoutInternalArray.new
    result_array.internal_array = @internal_array.values_at( *selectors )
    
    return result_array
    
  end

  #########
  #  zip  #
  #########
  
  ###
  # Converts any arguments to arrays, then merges elements of self with corresponding elements 
  #   from each argument. This generates a sequence of self.size n-element arrays, where n is 
  #   one more that the count of arguments. If the size of any argument is less than enumObj.size, 
  #   nil values are supplied. If a block is given, it is invoked for each output array, otherwise 
  #   an array of arrays is returned.
  #
  def zip( *args, & block )
    
    return_value = nil
    
    if block_given?
    else
      result_array = self.class::WithoutInternalArray.new
      result_array.internal_array = @internal_array.zip( *args )
      return_value = result_array
    end
    
    return return_value    
    
  end

  ######################################################################################################################
      private ##########################################################################################################
  ######################################################################################################################

  ###########################
  #  filter_insert_objects  #
  ###########################
  
  ###
  # Filter objects provided by request for insert. Existing filtering
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
  def filter_insert_objects( index, objects )
    
    # if we have less elements in self than the index we are inserting at
    # we need to make sure the nils inserted cascade
    if index > length
      nils_created = index - length
      index -= nils_created
      nils_created.times do |this_time|
        objects.unshift( nil )
      end
    end

    return index
    
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
  def perform_get_between_hooks( index )
    
    return undecorated_get( index )
    
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
  def perform_set_between_hooks( index, object )
    
    undecorated_set( index, object )
    
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
    
    first_index = index
    
    current_index = index
    
    objects.each do |this_object|
      # if we get nil back thats an insert did not happen
      if index = perform_single_object_insert_between_hooks( index, this_object )
        index += 1
        current_index = index
      else
        index = current_index
      end
    end
    
    return first_index
    
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
  
end