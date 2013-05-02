# -*- encoding : utf-8 -*-

module ::Array::Hooked::ArrayInterface
  
  include ::IdentifiesAs
  instances_identify_as!( ::Array, 
                          ::Array::Hooked )
  
  include ::Enumerable
  
  include ::Array::Hooked::ArrayInterface::ArrayMethods
  include ::Array::Hooked::ArrayInterface::AdditionalMethods
  include ::Array::Hooked::ArrayInterface::Undecorated
  include ::Array::Hooked::ArrayInterface::Hooks
  include ::Array::Hooked::ArrayInterface::WithoutHooks
  include ::Array::Hooked::ArrayInterface::EachRange
  
  extend ::Module::Cluster
  hooked_array_cluster = cluster( :hooked_array ).before_include

  ################
  #  self.class  #
  ################

  ###
  # @private
  #
  # Enable including class to act like an Array subclass.
  #
  hooked_array_cluster.extend( ::Array::Hooked::ArrayInterface::ClassInstance )

  ######################################
  #  self.class::WithoutInternalArray  #
  ######################################
  
  ###
  # @private
  #
  # Enable including class to automatically create self.class::WithoutInternalArray. 
  #   This class is used internally so that we can create a new instance to return, 
  #   and then create its internal Array instance using the internal Array instance's 
  #   corresponding method.
  #
  hooked_array_cluster.cascade_to( :class ) do |hooked_instance|
    unless hooked_instance.const_defined?( :WithoutInternalArray )
      hooked_instance_subclass = ::Class.new( hooked_instance ) do
        include ::Array::Hooked::ArrayInterface::WithoutInternalArray
      end
      hooked_instance.const_set( :WithoutInternalArray, hooked_instance_subclass )
    end
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
  
  ###
  # @private
  #
  # Initialize internal Array instance. 
  #
  #   This method is separated out so that the self.class::WithoutInternalArray subclass
  #   can override it (blanking it out). The result is that internally we can create a
  #   new instance to return, and then create its internal Array instance using the internal
  #   Array instance's corresponding method.
  #
  def initialize_internal_array( *array_initialization_args, & block )

    @internal_array = ::Array.new( *array_initialization_args, & block )
    
  end

  ######################
  #  initialize_clone  #
  ######################
  
  ###
  # Ensure that internal state (such as internal Array instance) is initialized 
  #   when #clone is called.
  #
  # @param hooked_array_clone
  #
  #        [Array::Hooked]
  #
  #        Cloned instance awaiting initialization of internal state. 
  #
  def initialize_clone( hooked_array_clone )
    
    super
    
    hooked_array_clone.internal_array = hooked_array_clone.internal_array.clone
        
  end

  ####################
  #  initialize_dup  #
  ####################
  
  ###
  # Ensure that internal state (such as internal Array instance) is initialized 
  #   when #dup is called.
  #
  # @param hooked_array_dup
  #
  #        [Array::Hooked]
  #
  #        Duped instance awaiting initialization of internal state. 
  #
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
  #         Certain subclasses (such as Array::Compositing) require lazy-loading of elements.
  #         In these contexts there are certain cases where elements not-yet-loaded must be 
  #         loaded. 
  #
  #         Methods exist to hook each of these conditions, with the one exception being the 
  #         splat operator (*array, which evaluates as: array_member1, array_member2, ...). 
  #
  #         The splat operator causes #to_a to be called *unless the object is already an Array*.
  #         If instance is already an Array instance then #to_a will not be called, which causes 
  #         lazy-loading elements not to be loaded (resulting in nil in their place).
  #
  #         As a result, Array::Hooked and subclasses cannot inherit from Array, but must act
  #         as proxies for an internal Array instance.
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

end
