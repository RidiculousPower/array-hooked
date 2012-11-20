
module ::Array::Hooked::ArrayInterface
  
  include ::IdentifiesAs
  
  instances_identify_as!( ::Array, 
                          ::Array::Hooked )
  
  include ::Array::Hooked::ArrayInterface::Undecorated
  include ::Array::Hooked::ArrayInterface::Hooks
  include ::Array::Hooked::ArrayInterface::WithoutHooks
  
  include ::Enumerable
  
  extend ::Module::Cluster
  
  cluster( :hooked_array ).before_include.cascade_to( :class ) do |hooked_instance|
    hooked_instance_subclass = ::Class.new( hooked_instance ) do
      include ::Array::Hooked::ArrayInterface::WithoutInternalArray
    end
    hooked_instance.const_set( :WithoutInternalArray, hooked_instance_subclass )
  end

  ################
  #  initialize  #
  ################

  ###
  # Initialize with reference a configuration instance.
  #
  # @overload initialize( configuration_instance, array_initialization_arg, ... )
  #
  #   @param [Object] configuration_instance 
  #   
  #          Object that instance will be attached to; primarily useful for reference from hooks.
  #   
  #   @param [Object] array_initialization_arg 
  #   
  #          Parameters passed through super to Array#initialize.
  #
  def initialize( configuration_instance = nil, *array_initialization_args, & block )
    
    @configuration_instance = configuration_instance
        
    initialize_internal_array( *array_initialization_args, & block )
    
  end

  ###############################
  #  initialize_internal_array  #
  ###############################
  
  def initialize_internal_array( *array_initialization_args, & block )

    @internal_array = ::Array.new( *array_initialization_args, & block )
    
  end

  ######################
  #  initialize_clone  #
  ######################
  
  def initialize_clone( hooked_array_clone )
    
    super
    
    hooked_array_clone.internal_array = hooked_array_clone.internal_array.clone
        
  end

  ####################
  #  initialize_dup  #
  ####################
  
  def initialize_dup( hooked_array_dup )
    
    super
    
    hooked_array_dup.internal_array = hooked_array_dup.internal_array.dup

  end

  ####################
  #  internal_array  #
  ####################
  
  ###
  # @!attribute [rw]
  #
  # @return [Array]
  #
  #         Internal Array instance used to hold state.
  #
  #         An internal Array instance is necessary to support lazy-loading of elements
  #         when a splat is called (*array), as the CRuby internals check if instance
  #         is already an Array instance prior to calling #to_a for conversion. If instance 
  #         is already an Array instance then #to_a will not be called, which causes 
  #         lazy-loading elements not to be loaded (resulting in nil in their place).
  #
  attr_accessor :internal_array
  
  ############################
  #  configuration_instance  #
  ############################

  ###
  # @!attribute [r]
  #
  # @return [Object]
  #
  #         Object that instance is attached to; primarily useful for reference from hooks.
  #
  attr_accessor :configuration_instance  

  #######
  #  +  #
  #######

  ####
  #
  # NOTE: this breaks + by causing it to modify the array like +=.
  # The alternative (+ breaking the array) was worse.
  #
  def +( array )

    return dup.push( *array )

  end
  
  #######
  #  -  #
  #######

  def -( array )
    
    result_array = dup
    result_array.delete_objects( *array )

    return result_array

  end

  #######
  #  *  #
  #######
  
  def *( other_array )

    result_array = dup
    result_array.internal_array *= other_array
    
    return result_array
    
  end

  #######
  #  &  #
  #######
  
  def &( other_array )
    
    result_array = dup
    result_array.internal_array &= other_array
    
    return result_array
    
  end

  #######
  #  |  #
  #######
  
  def |( other_array )
    
    result_array = dup
    result_array.internal_array |= other_array
    
    return result_array
    
  end

  ########
  #  ==  #
  ########
  
  def ==( other_array )
    
    return @internal_array == other_array

  end

  #########
  #  <=>  #
  #########
  
  def <=>( other_array )
    
    return @internal_array <=> other_array
    
  end
  
  ########
  #  <<  #
  ########
  
  def <<( object )

    return insert( length, object )

  end

  ###########
  #  assoc  #
  ###########
  
  def assoc( object )

    return @internal_array.assoc( object )

  end

  #############
  #  collect  #
  #############
  
  def collect

    return dup.collect!

  end

  #################
  #  combination  #
  #################
  
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
  
  def compact
    
    return dup.compact!
    
  end

  ###########
  #  count  #
  ###########
  
  def count( object = nil, & block )
    
    return @internal_array.count( object, & block )
    
  end

  ###########
  #  cycle  #
  ###########
  
  def cycle( number, & block )
    
    return_value = self
    
    if block_given?
      @internal_array.cycle( number, & block )
    else
      return_value = to_enum( __method__ )
    end
    
    return return_value
    
  end

  ##########
  #  drop  #
  ##########
  
  def drop( number )
    
    result_array = dup
    result_array.internal_array.drop( number )
    
    return result_array
    
  end

  ################
  #  drop_while  #
  ################
  
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
  
  def empty?
    
    return @internal_array.empty?
    
  end

  ###########
  #  fetch  #
  ###########
  
  def fetch( index, default = nil, & block )
    
    return @internal_array.fetch( index, default, & block )
    
  end

  ##########
  #  fill  #
  ##########
  
  def fill( *args, & block )
    
    @internal_array.fill( *args, & block )
    
    return self
    
  end

  ################
  #  find_index  #
  ################
  
  def find_index( object = nil, & block )
    
    return @internal_array.find_index( object, & block )
    
  end

  ###########
  #  index  #
  ###########
  
  alias_method :index, :find_index

  ###########
  #  first  #
  ###########
  
  def first
    
    return self[ 0 ]
    
  end

  #############
  #  flatten  #
  #############
  
  def flatten
    
    return dup.flatten!
    
  end

  ############
  #  freeze  #
  ############
  
  def freeze
    
    @internal_array.freeze
    
    return self
    
  end

  ##########
  #  hash  #
  ##########
  
  def hash
    
    return @internal_array.hash
    
  end

  ##############
  #  include?  #
  ##############
  
  def include?( object )
    
    return @internal_array.include?( object )
    
  end

  #############
  #  inspect  #
  #############
  
  def inspect
    
    return to_s
    
  end

  ##########
  #  join  #
  ##########
  
  def join( separator = $, )
    
    return @internal_array.join( separator )
    
  end

  ##########
  #  last  #
  ##########
  
  def last
    
    return self[ -1 ]
    
  end

  ############
  #  length  #
  ############
  
  def length
    
    return @internal_array.length
    
  end

  #########
  #  map  #
  #########
  
  alias_method :map, :collect

  ##########
  #  pack  #
  ##########
  
  def pack( template_string )
    
    return @internal_array.pack( template_string )
    
  end

  #################
  #  permutation  #
  #################
  
  def permutation( number = nil, & block )
    
    return_value = self
    
    if block_given?
      @internal_array.permutation( number, & block )
    else
      return_value = to_enum( __method__ )
    end
    
    return return_value

  end

  #############
  #  product  #
  #############
  
  def product( *other_arrays, & block )
    
    return @internal_array.product( * other_arrays, & block )
    
  end

  ############
  #  rassoc  #
  ############
  
  def rassoc( object )
    
    return @internal_array.rassoc( object )
    
  end

  ############
  #  reject  #
  ############
  
  def reject( & block )
    
    return dup.reject!( & block )
    
  end

  ##########################
  #  repeated_combination  #
  ##########################
  
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
  #  reverse  #
  #############
  
  def reverse

    return dup.reverse!

  end

  ##################
  #  reverse_each  #
  ##################
  
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
  
  def rotate( count = 1 )
    
    return dup.rotate!( count )
    
  end

  ############
  #  sample  #
  ############
  
  def sample( *args )
    
    return @internal_array.sample( *args )
    
  end

  ############
  #  select  #
  ############
  
  def select
    
    return dup.select!
    
  end

  #############
  #  shuffle  #
  #############
  
  def shuffle( random_number_generator = nil )
    
    return dup.shuffle!( random_number_generator )
    
  end

  ############
  #  length  #
  ############
  
  def length
    
    return @internal_array.length
    
  end

  ##########
  #  size  #
  ##########
  
  alias_method :size, :length

  ###########
  #  slice  #
  ###########
  
  def slice( *args )
    
    return dup.slice!( *args )
    
  end

  ##########
  #  sort  #
  ##########
  
  def sort( & block )
    
    return dup.sort!( & block )
    
  end

  ##########
  #  take  #
  ##########
  
  def take( number )
    
    return slice( 0, number - 1 )
    
  end

  ################
  #  take_while  #
  ################
  
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
  
  def to_a
    
    return self
    
  end

  ############
  #  to_ary  #
  ############
  
  def to_ary
    
    return self
    
  end

  ##########
  #  to_s  #
  ##########
  
  def to_s
    
    return @internal_array.to_s
    
  end

  ###############
  #  transpose  #
  ###############
  
  def transpose
    
    result_array = dup
    result_array.internal_array.transpose( other_array )
    
    return result_array
    
  end

  ##########
  #  uniq  #
  ##########
  
  def uniq( & block )
    
    return dup.uniq!( & block )
    
  end

  ###############
  #  values_at  #
  ###############
  
  def values_at( *selectors )
    
    result_array = self.class.new
    values = @internal_array.values_at( *selectors )
    result_array.internal_array = values
    
    return result_array
    
  end

  #########
  #  zip  #
  #########
  
  def zip( *args, & block )
    
    return_value = nil
    
    if block_given?
    else
      result_array = self.class.new
      zipped_internal_array = @internal_array.zip( *args )
      result_array.internal_array = zipped_internal_array
      return_value = result_array
    end
    
    return return_value    
    
  end

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
      
      object = perform_get_between_hooks( index )
    
      unless @without_hooks
        object = post_get_hook( index, object )
      end
      
    end
    
    return object
    
  end

  ########
  #  at  #
  ########
  
  alias_method( :at, :[] )

  #########
  #  []=  #
  #########

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
  
  alias_method :hooked_set, :[]=
  
  ############
  #  insert  #
  ############

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
  
  alias_method :hooked_insert, :insert
  
  ##########
  #  push  #
  ##########

  def push( *objects )
    
    return insert( length, *objects )
    
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

  ###################
  #  hooked_delete  #
  ###################
  
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

  ##############
  #  compact!  #
  ##############

  def compact!

    return keep_if do |object|
      object != nil
    end

  end

  ##############
  #  flatten!  #
  ##############

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

  ##############
  #  reverse!  #
  ##############

  def reverse!

    @internal_array.reverse!

    return self

  end
  
  #############
  #  rotate!  #
  #############

  def rotate!( rotate_count = 1 )

    @internal_array.rotate!( rotate_count )

    return self

  end
  
  #############
  #  select!  #
  #############

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

  ##############
  #  shuffle!  #
  ##############

  def shuffle!( random_number_generator = nil )

    @internal_array.shuffle!( random: random_number_generator )

    return self

  end

  ##############
  #  collect!  #
  ##############

  def collect!

    return to_enum unless block_given?

    self.each_with_index do |this_object, index|
      replacement_object = yield( this_object )
      self[ index ] = replacement_object
    end

    return self

  end

  ##########
  #  map!  #
  ##########
  
  alias_method :map!, :collect!

  ###########
  #  sort!  #
  ###########

  def sort!( & block )

    @internal_array.sort!( & block )

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

  ###########
  #  uniq!  #
  ###########

  def uniq!

    @internal_array.uniq!

    return self

  end

  #############
  #  unshift  #
  #############

  def unshift( object )

    insert( 0, object )

    return self

  end

  #########
  #  pop  #
  #########

  def pop

    object = delete_at( count - 1 )

    return object

  end

  ###########
  #  shift  #
  ###########

  def shift

    object = delete_at( 0 )

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
  
  ###########
  #  clear  #
  ###########

  def clear

    delete_if { true }

    return self

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
