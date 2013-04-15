# -*- encoding : utf-8 -*-

require_relative '../../lib/array-hooked.rb'

###################
#  Array::Hooked  #
###################

describe ::Array::Hooked do
  
  #########
  #  new  #
  #########
  
  it 'can initialize without args' do
    hooked_array = ::Array::Hooked.new
    hooked_array.is_a?( ::Array ).should == true
    hooked_array.should == [ ]
  end
  
  ###################################
  #  new( configuration_instance )  #
  ###################################
  
  it 'can initialize with only a configuration instance' do
    configuration_instance = ::Object.new
    hooked_array = ::Array::Hooked.new( configuration_instance )
    hooked_array.is_a?( ::Array ).should == true
    hooked_array.configuration_instance.should == configuration_instance
    hooked_array.should == [ ]
  end

  #########################################################
  #  new( configuration_instance, size, default_object )  #
  #########################################################
  
  it 'can initialize with size and default object' do
    configuration_instance = ::Object.new
    hooked_array = ::Array::Hooked.new( configuration_instance, 4, :default )
    hooked_array.is_a?( ::Array ).should == true
    hooked_array.configuration_instance.should == configuration_instance
    hooked_array.should == [ :default, :default, :default, :default ]
  end
  
  ##################################################
  #  new( configuration_instance, array_to_copy )  #
  ##################################################
  
  it 'can initialize with an array to copy' do
    configuration_instance = ::Object.new
    hooked_array = ::Array::Hooked.new( configuration_instance, [ :default, :default, :default, :default ] )
    hooked_array.is_a?( ::Array ).should == true
    hooked_array.configuration_instance.should == configuration_instance
    hooked_array.should == [ :default, :default, :default, :default ]
  end

  ##################################################
  #  new( configuration_instance, size, & block )  #
  ##################################################
  
  it 'can initialize with a size and a block' do
    configuration_instance = ::Object.new
    hooked_array = ::Array::Hooked.new( configuration_instance, 4 ) { :default }
    hooked_array.is_a?( ::Array ).should == true
    hooked_array.configuration_instance.should == configuration_instance
    hooked_array.should == [ :default, :default, :default, :default ]
  end
  
  ########
  #  []  #
  ########

  it 'can create a new instance using [ *members ]' do
    hooked_array = ::Array::Hooked[ :default, :default, :default, :default ]
    hooked_array.is_a?( ::Array ).should == true
    hooked_array.should == [ :default, :default, :default, :default ]
  end
  
end

#########################################
#  Array::Hooked::WithoutInternalArray  #
#########################################

describe ::Array::Hooked::WithoutInternalArray do

  #########
  #  new  #
  #########

  it 'can initialize without creating the internal array' do
    array_without_internal_array = ::Array::Hooked::WithoutInternalArray.new
    array_without_internal_array.internal_array.should == nil
  end
  
  ###################################
  #  new( configuration_instance )  #
  ###################################
  
  it 'can initialize with a configuration instance without creating the internal array' do
    configuration_instance = ::Object.new
    array_without_internal_array = ::Array::Hooked::WithoutInternalArray.new( configuration_instance )
    array_without_internal_array.internal_array.should == nil
    array_without_internal_array.configuration_instance.should == configuration_instance
  end
    
end

######################
#  <#Array::Hooked>  #
######################

describe ::Array::Hooked do
  
  # RSpec seems to get confused since we are proxying an internal Array -
  # hooked_array.should == equivalent array works fine, but if the second
  # array is not equal, RSpec throws an error that conversion was not possible.
  # Writing it instead as: ( hooked_array == hooked_array_two ).should == true
  # makes things work as expected.
  
  ########
  #  ==  #
  ########
  
  it 'can == another array' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    hooked_array_two = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    hooked_array.internal_array.should == hooked_array_two.internal_array
    ( hooked_array == hooked_array_two ).should == true
  end

  #########
  #  <=>  #
  #########
  
  it 'can <=> another array' do
    ( ::Array::Hooked.new( nil, [ :A, :B, :C ] ) <=> ::Array::Hooked.new( nil, [ :A, :B, :C ] ) ).should == 0
    ( ::Array::Hooked.new( nil, [ :A, :B, :C ] ) <=> ::Array::Hooked.new( nil, [ :A, :B ] ) ).should == 1
    ( ::Array::Hooked.new( nil, [ :A, :B ] ) <=> ::Array::Hooked.new( nil, [ :A, :B, :C ] ) ).should == -1
  end
  
  #######
  #  +  #
  #######

  it 'can + another array' do
    hooked_array = ::Array::Hooked.new( nil, [ :A ] )
    hooked_array_two = hooked_array + [ :B ]
    hooked_array_two.is_a?( ::Array::Hooked ).should == true
    hooked_array_two.should == [ :A, :B ]
    hooked_array.should == [ :A ]
  end
  
  #######
  #  -  #
  #######
  
  it 'can - another array' do
    hooked_array = ::Array::Hooked.new( nil, [ :A ] )
    hooked_array_two = hooked_array - [ :A ]
    hooked_array_two.is_a?( ::Array::Hooked ).should == true
    hooked_array_two.should == [ ]
    hooked_array.should == [ :A ]
  end

  #######
  #  *  #
  #######
  
  it 'can * by an integer' do
    hooked_array = ::Array::Hooked.new( nil, [ :A ] )
    hooked_array_two = hooked_array * 3
    hooked_array_two.is_a?( ::Array::Hooked ).should == true
    hooked_array_two.should == [ :A, :A, :A ]
    hooked_array.should == [ :A ]
  end

  it 'can * by a string' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :A, :A ] )
    joined_string = hooked_array * ', '
    joined_string.should == 'A, A, A'
    hooked_array.should == [ :A, :A, :A ]
  end
  
  #######
  #  &  #
  #######
  
  it 'can & another array' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    hooked_array_two = ::Array::Hooked.new( nil, [ :B, :C, :D ] )
    hooked_array_three = hooked_array & hooked_array_two
    hooked_array_three.should == [ :B, :C ]
  end

  #######
  #  |  #
  #######
  
  it 'can | another array' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    hooked_array_two = ::Array::Hooked.new( nil, [ :B, :C, :D ] )
    hooked_array_three = hooked_array | hooked_array_two
    hooked_array_three.should == [ :A, :B, :C, :D ]
  end

  ########
  #  <<  #
  ########

  it 'can << elements' do
    hooked_array = ::Array::Hooked.new
    hooked_array << :A
    hooked_array.should == [ :A ]
  end

  ########
  #  []  #
  ########

  it 'can retrieve elements with an index' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    hooked_array[ 0 ].should == :A
    hooked_array[ 1 ].should == :B
    hooked_array[ 2 ].should == :C
  end

  it 'can retrieve elements with a start index and a length' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    hooked_array_two = hooked_array[ 1, 2 ]
    hooked_array_two.is_a?( ::Array::Hooked ).should == true
    hooked_array_two.should == [ :B, :C ]
  end

  it 'can retrieve elements with a range' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    hooked_array_two = hooked_array[ 1..2 ]
    hooked_array_two.is_a?( ::Array::Hooked ).should == true
    hooked_array_two.should == [ :B, :C ]
  end

  #########
  #  []=  #
  #########

  it 'can store elements at an index' do
    hooked_array = ::Array::Hooked.new
    hooked_array[ 0 ] = :A
    hooked_array.should == [ :A ]
    hooked_array[ 1 ] = :B
    hooked_array.should == [ :A, :B ]
    hooked_array[ 0 ] = :D
    hooked_array.should == [ :D, :B ]
  end

  it 'can store elements with a start index and a length' do
    hooked_array = ::Array::Hooked.new
    hooked_array[ 0, 1 ] = :A
    hooked_array.should == [ :A ]
    hooked_array[ 1, 1 ] = :B
    hooked_array.should == [ :A, :B ]
    hooked_array[ 0, 2 ] = :C
    hooked_array.should == [ :C ]
  end

  it 'can store elements with a range' do
    hooked_array = ::Array::Hooked.new
    hooked_array[ 0..1 ] = :A
    hooked_array.should == [ :A ]
    hooked_array[ 1..1 ] = :B
    hooked_array.should == [ :A, :B ]
    hooked_array[ 0..1 ] = :C
    hooked_array.should == [ :C ]
  end

  ################
  #  hooked_set  #
  ################
  
  it 'aliases set for direct calling from subclasses' do
    ::Array::Hooked.instance_method( :hooked_set ).should == ::Array::Hooked.instance_method( :[]= )
  end

  ###########
  #  assoc  #
  ###########

  it 'can assoc search' do
    hooked_array = ::Array::Hooked.new( nil, [ [:A, 1, 2, 3 ], [:B, 4, 5, 6], [:C, 7, 8, 9] ] )
    hooked_array.assoc( :B ).should == [:B, 4, 5, 6]
  end

  ########
  #  at  #
  ########

  it 'aliases []' do
    ::Array::Hooked.instance_method( :at ).should == ::Array::Hooked.instance_method( :[] )
  end

  ###########
  #  clear  #
  ###########

  it 'can clear, causing present elements to be excluded' do
    hooked_array = ::Array::Hooked.new( nil, [ :A ] )
    hooked_array.clear
    hooked_array.should == [ ]
  end

  #############
  #  collect  #
  #############

  it 'can collect with a block' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    hooked_array_two = hooked_array.collect { :C }
    hooked_array_two.should == [ :C, :C, :C ]
  end

  it 'can collect with an enumerator' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    enum = hooked_array.collect
    enum.is_a?( Enumerator ).should == true
  end

  ##############
  #  collect!  #
  ##############
  
  it 'can replace by collect with a block' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    hooked_array.collect! { :C }
    hooked_array.should == [ :C, :C, :C ]
  end

  it 'can replace by collect with an enumerator' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    enum = hooked_array.collect!
    enum.is_a?( Enumerator ).should == true
  end

  #################
  #  combination  #
  #################

  it 'can yield combinations with a block' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    combinations = [ ]
    hooked_array.combination( 2 ) do |this_combination|
      combinations.push( this_combination )
    end
    internal_combinations = [ ]
    hooked_array.internal_array.combination( 2 ) do |this_combination|
      internal_combinations.push( this_combination )
    end
    combinations.should == internal_combinations
  end


  it 'can yield combinations with an enumerator' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    enum = hooked_array.combination( 2 )
    enum.is_a?( Enumerator ).should == true
  end

  #############
  #  compact  #
  #############

  it 'can compact' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, nil, :B, nil, :C, nil ] )
    hooked_array_two = hooked_array.compact
    hooked_array_two.should == [ :A, :B, :C ]
  end

  ##############
  #  compact!  #
  ##############

  it 'can compact' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, nil, :B, nil, :C, nil ] )
    hooked_array.compact!
    hooked_array.should == [ :A, :B, :C ]
  end

  ############
  #  concat  #
  ############

  it 'can concat elements' do
    hooked_array = ::Array::Hooked.new
    hooked_array.concat( [ :A ] )
    hooked_array.should == [ :A ]
  end

  ###########
  #  count  #
  ###########

  it 'can return count of elements (length/size)' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    hooked_array.count.should == 3
  end

  it 'can count elements matching object' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    hooked_array.count( :A ).should == 1
  end

  it 'can count elements for which block is true' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    hooked_array.count do |this_object|
      this_object == :A
    end.should == 1
  end

  ###########
  #  cycle  #
  ###########

  it 'repeatedly cycle a block' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    result_array = [ ]
    enum = hooked_array.cycle( 2 ) do |this_object|
      result_array.push( this_object )
    end
    result_array.sort.should == ( hooked_array.internal_array * 2 ).sort
  end

  it 'repeatedly cycle via enumerator' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    enum = hooked_array.cycle( 2 )
    enum.is_a?( Enumerator ).should == true
  end

  ############
  #  delete  #
  ############
  
  it 'can delete elements' do
    hooked_array = ::Array::Hooked.new( nil, [ :A ] )
    hooked_array.delete( :A )
    hooked_array.should == [ ]
  end

  it 'can delete elements with block to process objects not found' do
    hooked_array = ::Array::Hooked.new( nil, [ :A ] )
    hooked_array.delete( :A ) { :B }.should == :A
    hooked_array.should == [ ]
    hooked_array.delete( :A ) { :B }.should == :B
  end

  ###################
  #  hooked_delete  #
  ###################

  it 'aliases delete for direct calling from subclasses' do
    ::Array::Hooked.instance_method( :hooked_delete ).should == ::Array::Hooked.instance_method( :delete )
  end

  ####################
  #  delete_objects  #
  ####################

  it 'can delete multiple elements' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B ] )
    hooked_array.delete_objects( :A, :B )
    hooked_array.should == [ ]
  end

  ###############
  #  delete_at  #
  ###############

  it 'can delete by indexes' do
    hooked_array = ::Array::Hooked.new( nil, [ :A ] )    
    hooked_array.delete_at( 0 )
    hooked_array.should == [ ]
  end

  #######################
  #  delete_at_indexes  #
  #######################

  it 'can delete by indexes' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    hooked_array.delete_at_indexes( 0, 1 )
    hooked_array.should == [ :C ]
  end

  ###############
  #  delete_if  #
  ###############

  it 'can delete by block' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    hooked_array.delete_if do |object|
      object != :C
    end
    hooked_array.should == [ :C ]
  end

  it 'can delete by enumerator' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    hooked_array.delete_if.is_a?( Enumerator ).should == true
  end
  
  ##########
  #  drop  #
  ##########

  it 'can drop elements' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    hooked_array_two = hooked_array.drop( 2 )
    hooked_array_two.is_a?( ::Array::Hooked ).should == true
    hooked_array_two.should == [ :C ]
  end

  ################
  #  drop_while  #
  ################

  it 'can drop elements for a block' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    hooked_array_two = hooked_array.drop_while do |this_object|
      this_object != :C
    end
    hooked_array_two.is_a?( ::Array::Hooked ).should == true
    hooked_array_two.should == [ :C ]
  end

  it 'can drop elements for enumerator' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    hooked_array.drop_while.is_a?( Enumerator ).should == true
  end

  ##########
  #  each  #
  ##########

  it 'can iterate for a block' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    result_array = [ ]
    hooked_array.each do |this_object|
      result_array.push( this_object )
    end
    result_array.should == [ :A, :B, :C ]
  end

  it 'can iterate for enumerator' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    enumerator = hooked_array.each
    enumerator.is_a?( Enumerator ).should == true
  end

  ################
  #  each_index  #
  ################

  it 'can iterate indexes for a block' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    result_array = [ ]
    hooked_array.each_index do |this_object|
      result_array.push( this_object )
    end
    result_array.should == [ 0, 1, 2 ]
  end

  it 'can iterate indexes for enumerator' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    enumerator = hooked_array.each_index
    enumerator.is_a?( Enumerator ).should == true
  end

  ############
  #  empty?  #
  ############

  it 'can report if empty' do
    hooked_array = ::Array::Hooked.new
    hooked_array.empty?.should == true
  end

  it 'can report if not empty' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    hooked_array.empty?.should == false
  end

  ##########
  #  eql?  #
  ##########

  it 'can report it is the same instance' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    hooked_array.eql?( hooked_array ).should == true
  end

  it 'can report it is not the same instance' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    hooked_array.eql?( Object.new ).should == false
  end

  it 'can report it has the same contents' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    hooked_array_two = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    hooked_array.eql?( hooked_array_two ).should == true
  end

  ###########
  #  fetch  #
  ###########

  it 'can fetch an index' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    hooked_array.fetch( 1 ).should == :B
    Proc.new { hooked_array.fetch( 3 ) }.should raise_error( IndexError )
  end

  it 'can fetch an index or return a default value' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    hooked_array.fetch( 1, :default ).should == :B
    hooked_array.fetch( 3, :default ).should == :default
  end

  it 'can fetch an index or return a default value from a block' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    hooked_array.fetch( 1 ) { :default } .should == :B
    hooked_array.fetch( 3 ) { :default } .should == :default
  end

  ##########
  #  fill  #
  ##########

  it 'can fill indexes with an object' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    hooked_array.fill( :A )
    hooked_array.should == [ :A, :A, :A ]
  end

  it 'can fill indexes with an object from a start index for a length' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    hooked_array.fill( :A, 1, 2 )
    hooked_array.should == [ :A, :A, :A ]
  end

  it 'can fill a range with an object' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    hooked_array.fill( :A, 1..2 )
    hooked_array.should == [ :A, :A, :A ]
  end

  it 'can fill with a block' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    hooked_array.fill { :A }
    hooked_array.should == [ :A, :A, :A ]
  end

  it 'can fill from a start index for a length with a block' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    hooked_array.fill( 1, 2 ) { :A }
    hooked_array.should == [ :A, :A, :A ]
  end

  it 'can fill a range with a block' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    hooked_array.fill( 1..2 ) { :A }
    hooked_array.should == [ :A, :A, :A ]
  end

  ################
  #  find_index  #
  ################

  it 'can find an index for an object' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    hooked_array.find_index( :B ).should == 1
  end

  it 'can find an index for a block' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    hooked_array.find_index do |this_object|
     this_object == :B
    end.should == 1
  end

  it 'can find an index for enumerator' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    enumerator = hooked_array.find_index
    enumerator.is_a?( Enumerator ).should == true
  end

  ###########
  #  index  #
  ###########

  it 'aliases #index to #find_index' do
    ::Array::Hooked.instance_method( :index ).should == ::Array::Hooked.instance_method( :find_index )
  end

  ###########
  #  first  #
  ###########

  it 'can get the first element' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    hooked_array.first.should == :A
  end

  it 'can get the first n elements' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    hooked_array_two = hooked_array.first( 2 )
    hooked_array_two.is_a?( ::Array::Hooked ).should == true
    hooked_array_two.should == [ :A, :B ]
  end

  #############
  #  flatten  #
  #############

  it 'can flatten' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, [ :F_A, [ :F_B ] ], :B, [ :F_C ], :C, [ :F_D ], [ :F_E ] ] )
    hooked_array_two = hooked_array.flatten
    hooked_array_two.is_a?( ::Array::Hooked ).should == true
    ( hooked_array_two == [ :A, :F_A, [ :F_B ], :B, :F_C, :C, :F_D, :F_E ] ).should == true
    ( hooked_array == [ :A, [ :F_A, [ :F_B ] ], :B, [ :F_C ], :C, [ :F_D ], [ :F_E ] ] ).should == true
  end

  it 'can flatten to n depth' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, [ :F_A, [ :F_B ] ], :B, [ :F_C ], :C, [ :F_D ], [ :F_E ] ] )
    hooked_array_two = hooked_array.flatten( 2 )
    hooked_array_two.is_a?( ::Array::Hooked ).should == true
    hooked_array_two.should == [ :A, :F_A, :F_B, :B, :F_C, :C, :F_D, :F_E ]
    ( hooked_array == [ :A, [ :F_A, [ :F_B ] ], :B, [ :F_C ], :C, [ :F_D ], [ :F_E ] ] ).should == true
  end

  ##############
  #  flatten!  #
  ##############

  it 'can flatten' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, [ :F_A, :F_B ], :B, [ :F_C ], :C, [ :F_D ], [ :F_E ] ] )
    hooked_array.flatten!
    hooked_array.should == [ :A, :F_A, :F_B, :B, :F_C, :C, :F_D, :F_E ]
  end

  it 'can flatten to n depth' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, [ :F_A, [ :F_B ] ], :B, [ :F_C ], :C, [ :F_D ], [ :F_E ] ] )
    hooked_array.flatten!( 2 )
    hooked_array.should == [ :A, :F_A, :F_B, :B, :F_C, :C, :F_D, :F_E ]
  end
  
  ############
  #  freeze  #
  ############

  it 'can freeze' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    hooked_array.freeze
    Proc.new { hooked_array.push( :D ) }.should raise_error( ::RuntimeError )
  end

  ##########
  #  hash  #
  ##########

  it 'two hooked arrays with same content have the same hash' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    hooked_array_two = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    hooked_array.hash.should == hooked_array_two.hash
  end

  it 'two arrays with same content have the same hash' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    hooked_array_two = ::Array.new( [ :A, :B, :C ] )
    hooked_array.hash.should == hooked_array_two.hash
  end

  ##############
  #  include?  #
  ##############

  it 'can report if an object is included in array' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    hooked_array.include?( :A ).should == true
  end

  it 'can report if an object is not included in array' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    hooked_array.include?( :D ).should == false
  end

  #############
  #  inspect  #
  #############

  it 'can output as string' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    hooked_array.inspect.should == '[:A, :B, :C]'
  end

  ##########
  #  join  #
  ##########

  it 'can join elements with no separation' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    hooked_array.join.should == 'ABC'
  end

  it 'can join with string' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    hooked_array.join( ', ' ).should == 'A, B, C'
  end

  #############
  #  keep_if  #
  #############

  it 'can keep by block' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    hooked_array.keep_if do |object|
      object == :C
    end
    hooked_array.should == [ :C ]
  end
  
  it 'can keep by enumerator' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    enumerator = hooked_array.keep_if
    enumerator.is_a?( Enumerator ).should == true
  end

  ##########
  #  last  #
  ##########

  it 'can return last object' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    hooked_array.last.should == :C
  end

  it 'can return last n objects' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    hooked_array_two = hooked_array.last( 2 )
    hooked_array_two.is_a?( ::Array::Hooked ).should == true
    hooked_array_two.should == [ :B, :C ]
  end

  ############
  #  length  #
  ############

  it 'can report length/size' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    hooked_array.length.should == 3
  end

  #########
  #  map  #
  #########

  it 'aliases collect' do
    ::Array::Hooked.instance_method( :map ).should == ::Array::Hooked.instance_method( :collect )
  end

  ##########
  #  map!  #
  ##########

  it 'aliases collect!' do
    ::Array::Hooked.instance_method( :map! ).should == ::Array::Hooked.instance_method( :collect! )
  end

  ##########
  #  pack  #
  ##########

  it 'can pack via template string' do
    hooked_array = ::Array::Hooked.new( nil, [ 'A', 'B', 'C' ] )
    hooked_array.pack( 'm' ).should == hooked_array.internal_array.pack( 'm' )
  end

  #################
  #  permutation  #
  #################

  it 'can return permutations by block' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    permutations = [ ]
    hooked_array.permutation do |this_permutation|
      permutations.push( this_permutation )
    end
    internal_permutations = [ ]
    hooked_array.internal_array.permutation do |this_permutation|
      internal_permutations.push( this_permutation )
    end
    permutations.should == internal_permutations
  end

  it 'can return permutations by enumerator' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    enumerator = hooked_array.permutation
    enumerator.is_a?( Enumerator ).should == true
  end
  
  it 'can return a number of permutations by block' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    permutations = [ ]
    hooked_array.permutation( 2 ) do |this_permutation|
      permutations.push( this_permutation )
    end
    internal_permutations = [ ]
    hooked_array.internal_array.permutation( 2 ) do |this_permutation|
      internal_permutations.push( this_permutation )
    end
    permutations.length.should == 6
    permutations.should == internal_permutations
  end
  
  it 'can return a number of permutations by enumerator' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    enumerator = hooked_array.permutation( 2 )
    enumerator.is_a?( Enumerator ).should == true
  end

  #########
  #  pop  #
  #########
  
  it 'can pop the final element' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    hooked_array.pop.should == :C
    (hooked_array == [ :A, :B ] ).should == true
  end

  it 'can pop the final n elements' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    popped_array = hooked_array.pop( 2 )
    popped_array.should == [ :B, :C ]
    (hooked_array == [ :A ] ).should == true
  end

  #############
  #  product  #
  #############

  it 'can return all products of arrays' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    hooked_array_two = ::Array::Hooked.new( nil, [ :D, :E, :F ] )
    hooked_product = hooked_array.product( hooked_array_two )
    internal_product = hooked_array.internal_array.product( hooked_array_two.internal_array )
    ( hooked_product == internal_product ).should == true
  end

  it 'can return self after processing all products of arrays with block' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    hooked_array_two = ::Array::Hooked.new( nil, [ :D, :E, :F ] )
    internal_product = hooked_array.internal_array.product( hooked_array_two.internal_array )
    hooked_product = []
    return_value = hooked_array.product( hooked_array_two ) do |this_product|
      hooked_product.push( this_product )
    end
    ( hooked_product == internal_product ).should == true
    return_value.should == hooked_array
  end

  ##########
  #  push  #
  ##########

  it 'can append object(s) to end of array' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    hooked_array.push( :D, :E, :F )
    hooked_array.should == [ :A, :B, :C, :D, :E, :F ]
  end

  ############
  #  rassoc  #
  ############

  it 'can right associative search' do
    hooked_array = ::Array::Hooked.new( nil, [ [ 1, :A], [2, :B], [3, :C], [4, :D] ] )
    hooked_array.rassoc( :C ).should == [3, :C]
    hooked_array.rassoc( :E ).should == nil
  end

  ############
  #  reject  #
  ############

  it 'can reject elements by block' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    hooked_array_reject = hooked_array.reject do |object|
      object != :C
    end
    hooked_array_reject.is_a?( ::Array::Hooked ).should == true
    hooked_array.should == [ :A, :B, :C ]
    hooked_array_reject.should == [ :C ]
  end

  it 'can reject elements by enumerator' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    enumerator = hooked_array.reject
    enumerator.is_a?( Enumerator ).should == true
  end

  #############
  #  reject!  #
  #############

  it 'can reject by block' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    hooked_array.reject! do |object|
      object != :C
    end
    hooked_array.should == [ :C ]
  end

  it 'can reject by enumerator' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    enumerator = hooked_array.reject!
    enumerator.is_a?( Enumerator ).should == true
  end
  
  ##########################
  #  repeated_combination  #
  ##########################

  it 'can do repeated combination by block' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    combinations = [ ]
    hooked_array.repeated_combination( 2 ) do |this_combination|
      combinations.push( this_combination )
    end
    internal_combinations = [ ]
    hooked_array.internal_array.repeated_combination( 2 ) do |this_combination|
      internal_combinations.push( this_combination )
    end
    combinations.should == internal_combinations
  end

  it 'can do repeated combination by enumerator' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    enumerator = hooked_array.repeated_combination( 2 )
    enumerator.is_a?( Enumerator ).should == true
  end

  ##########################
  #  repeated_permutation  #
  ##########################

  it 'can do repeated permutation by block' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    permutations = [ ]
    hooked_array.repeated_permutation( 2 ) do |this_permutation|
      permutations.push( this_permutation )
    end
    internal_permutations = [ ]
    hooked_array.internal_array.repeated_permutation( 2 ) do |this_permutation|
      internal_permutations.push( this_permutation )
    end
    permutations.should == internal_permutations
  end

  it 'can do repeated permutation by enumerator' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    enumerator = hooked_array.repeated_permutation( 2 )
    enumerator.is_a?( Enumerator ).should == true
  end

  #############
  #  replace  #
  #############

  it 'can replace self' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    hooked_array.replace( [ :D, :E, :F ] )
    hooked_array.should == [ :D, :E, :F ]
  end
  
  ###########################
  #  filter_insert_indexes  #
  ###########################
  
  context '#filter_insert_indexes' do
    let( :hooked_array ) { ::Array::Hooked.new( nil, [ :A, :B, :C ] ) }
    let( :objects ) { [ 1, 2, 3, 4 ] }
    it 'will filter indexes beyond size and insert nil(s), adjusting index to bounds' do
      hooked_array.filter_insert_indexes( 5, objects )
      objects.should == [ nil, nil, 1, 2, 3, 4 ]
    end
    it 'will filter indexes beyond -size and insert nil(s), adjusting index to bounds' do
      hooked_array.filter_insert_indexes( -5, objects )
      objects.should == [ 1, 2, 3, 4, nil, nil ]
    end
  end

  ############
  #  insert  #
  ############

  it 'can insert elements' do
    hooked_array = ::Array::Hooked.new
    hooked_array.insert( 3, :D )
    hooked_array.should == [ nil, nil, nil, :D ]
    hooked_array.insert( 1, :B )
    hooked_array.should == [ nil, :B, nil, nil, :D ]
    hooked_array.insert( 2, :C )
    hooked_array.should == [ nil, :B, :C, nil, nil, :D ]
  end

  ###################
  #  hooked_insert  #
  ###################

  it 'aliases insert for direct calling from subclasses' do
    ::Array::Hooked.instance_method( :hooked_insert ).should == ::Array::Hooked.instance_method( :insert )
  end

  #############
  #  reverse  #
  #############

  it 'can return a duplicate of self, reversed' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    hooked_array_two = hooked_array.reverse
    hooked_array_two.is_a?( ::Array::Hooked )
    hooked_array.should == [ :A, :B, :C ]
    hooked_array_two.should == [ :C, :B, :A ]
  end

  ##############
  #  reverse!  #
  ##############

  it 'can reverse self' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    hooked_array.reverse!
    hooked_array.should == [ :C, :B, :A ]
  end

  ##################
  #  reverse_each  #
  ##################

  it 'can iterate backwards with a block' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    result_array = [ ]
    hooked_array.reverse_each do |this_object|
      result_array.push( this_object )
    end
    result_array.should == [ :C, :B, :A ]
  end

  it 'can iterate backwards with an enumerator' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    enumerator = hooked_array.reverse_each
    enumerator.is_a?( Enumerator ).should == true
  end

  ############
  #  rindex  #
  ############

  it 'can return last index matching object' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    hooked_array.rindex( :B ).should == 1
  end

  it 'can return last index matching block' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    hooked_array.rindex do |this_object|
      this_object == :B
    end.should == 1
  end

  it 'can return last index matching enumerator' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    enumerator = hooked_array.rindex
    enumerator.is_a?( Enumerator ).should == true
  end

  ############
  #  rotate  #
  ############

  it 'can return a duplicate of self rotated' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    hooked_array_two = hooked_array.rotate
    hooked_array_two.is_a?( ::Array::Hooked ).should == true
    hooked_array.should == [ :A, :B, :C ]
    hooked_array_two.should == [ :B, :C, :A ]
  end

  it 'can return a duplicate of self rotated in reverse' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    hooked_array_two = hooked_array.rotate( -1 )
    hooked_array_two.is_a?( ::Array::Hooked ).should == true
    hooked_array.should == [ :A, :B, :C ]
    hooked_array_two.should == [ :C, :A, :B ]
  end
  
  #############
  #  rotate!  #
  #############

  it 'can rotate self' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    hooked_array.rotate!
    hooked_array.should == [ :B, :C, :A ]
  end

  it 'can rotate self in reverse' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    hooked_array.rotate!( -1 )
    hooked_array.should == [ :C, :A, :B ]
  end
  
  ############
  #  sample  #
  ############

  it 'can sample an object' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    sample = hooked_array.sample
    hooked_array.include?( sample ).should == true
  end

  it 'can sample with a random number generator' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    sample = hooked_array.sample( random: Random.new( 1 ) )
    hooked_array.include?( sample ).should == true
  end

  it 'can sample n elements' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    sample = hooked_array.sample( 2 )
    sample.each do |this_sample|
      hooked_array.include?( this_sample ).should == true
    end
  end

  it 'can sample n elements with a random number generator' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    sample = hooked_array.sample( 2, random: Random.new( 1 ) )
    sample.each do |this_sample|
      hooked_array.include?( this_sample ).should == true
    end
  end

  ############
  #  select  #
  ############

  it 'can select items using a block' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    hooked_array_two = hooked_array.select do |object|
      object == :C
    end
    hooked_array.should == [ :A, :B, :C ]
    hooked_array_two.should == [ :C ]
  end

  it 'can select items using an enumerator' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    enumerator = hooked_array.select
    enumerator.is_a?( Enumerator ).should == true
  end

  #############
  #  select!  #
  #############

  it 'can keep by select with block' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    hooked_array.select! do |object|
      object == :C
    end
    hooked_array.should == [ :C ]
  end

  it 'can keep by select with enumerator' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    enumerator = hooked_array.select!
    enumerator.is_a?( Enumerator ).should == true
  end
  
  ###########
  #  shift  #
  ###########
  
  it 'can shift the first element' do
    hooked_array = ::Array::Hooked.new( nil, [ :A ] )
    hooked_array.shift.should == :A
    hooked_array.should == [ ]
  end

  it 'can shift the first n elements' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    hooked_array_two = hooked_array.shift( 2 )
    hooked_array_two.is_a?( ::Array::Hooked ).should == true
    hooked_array_two.should == [ :A, :B ]
    hooked_array.should == [ :A, :B, :C ]
  end
  
  #############
  #  shuffle  #
  #############

  it 'can return shuffled duplicate' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    hooked_array_two = nil
    shuffled = false
    100.times do
      hooked_array_two = hooked_array.shuffle
      break if shuffled = ( hooked_array_two != hooked_array )
    end
    hooked_array_two.is_a?( ::Array::Hooked ).should == true
    shuffled.should == true
  end

  it 'can return shuffled duplicate using random number generator' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    hooked_array_two = nil
    shuffled = false
    100.times do
      hooked_array_two = hooked_array.shuffle( random: Random.new( 1 ) )
      break if shuffled = ( hooked_array_two != hooked_array )
    end
    hooked_array_two.is_a?( ::Array::Hooked ).should == true
    shuffled.should == true
  end

  ##############
  #  shuffle!  #
  ##############

  it 'can shuffle self' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    shuffled = false
    100.times do
      hooked_array.shuffle!
      break if shuffled = ( hooked_array != [ :A, :B, :C ] )
    end
    shuffled.should == true
  end

  it 'can shuffle self with a random number generator' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    shuffled = false
    100.times do
      hooked_array.shuffle!( random: Random.new( 1 ) )
      break if shuffled = ( hooked_array != [ :A, :B, :C ] )
    end
    shuffled.should == true
  end
  
  ##########
  #  size  #
  ##########

  it 'aliases #length as #size' do
    ::Array::Hooked.instance_method( :size ).should == ::Array::Hooked.instance_method( :length )
  end

  ###########
  #  slice  #
  ###########

  it 'can slice an index' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    hooked_array.slice( 0 ).should == :A
    hooked_array.should == [ :A, :B, :C ]
  end

  it 'can slice from a start index for a length' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ])
    hooked_array_two = hooked_array.slice( 0, 1 )
    hooked_array_two.is_a?( ::Array::Hooked ).should == true
    hooked_array_two.should == [ :A ]
    hooked_array.should == [ :A, :B, :C ]
  end
  
  it 'can slice a range' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ])
    hooked_array_two = hooked_array.slice( 0..1 )
    hooked_array_two.is_a?( ::Array::Hooked ).should == true
    hooked_array_two.should == [ :A, :B ]
    hooked_array.should == [ :A, :B, :C ]
  end

  ############
  #  slice!  #
  ############
  
  it 'can slice an index' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    hooked_array.slice!( 0 ).should == :A
    hooked_array.should == [ :B, :C ]
  end
  
  it 'can slice from a start index for a length' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ])
    hooked_array_two = hooked_array.slice!( 0, 1 )
    hooked_array_two.is_a?( ::Array::Hooked ).should == true
    hooked_array_two.should == [ :A ]
    hooked_array.should == [ :B, :C ]
  end

  it 'can slice a range' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ])
    hooked_array_two = hooked_array.slice!( 0..1 )
    hooked_array_two.is_a?( ::Array::Hooked ).should == true
    hooked_array_two.should == [ :A ]
    hooked_array.should == [ :B, :C ]
  end
  
  ##########
  #  sort  #
  ##########

  it 'can return a sorted duplicate' do
    hooked_array = ::Array::Hooked.new( nil, [ :C, :B, :A ] )
    hooked_array_two = hooked_array.sort
    hooked_array_two.should == [ :A, :B, :C ]
    hooked_array.should == [ :C, :B, :A ]
  end

  it 'can return a duplicate sorted by a block' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    hooked_array_two = hooked_array.sort do |a, b|
      if a < b
        1
      elsif a > b
        -1
      elsif a == b
        0
      end
    end
    hooked_array_two.should == [ :C, :B, :A ]
    hooked_array.should == [ :A, :B, :C ]
  end

  ###########
  #  sort!  #
  ###########

  it 'can sort self by block' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    hooked_array.sort! do |a, b|
      if a < b
        1
      elsif a > b
        -1
      elsif a == b
        0
      end
    end
    hooked_array.should == [ :C, :B, :A ]
  end

  ##############
  #  sort_by!  #
  ##############

  it 'can sort itself by result provided by block' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    hooked_array.sort_by! do |object|
      case object
      when :A
        :B
      when :B
        :A
      when :C
        :C
      end
    end
    hooked_array.should == [ :B, :A, :C ]
  end

  it 'can sort itself by result provided by enumerator' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    enumerator = hooked_array.sort_by!
    enumerator.is_a?( Enumerator ).should == true
  end
  
  ##########
  #  take  #
  ##########

  it 'can take n elements' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    hooked_array_two = hooked_array.take( 2 )
    hooked_array_two.is_a?( ::Array::Hooked ).should == true
    hooked_array_two.should == [ :A, :B ]
  end

  ################
  #  take_while  #
  ################

  it 'can take elements via block until block returns false' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    hooked_array_two = hooked_array.take_while do |this_object|
      this_object != :B
    end
    hooked_array_two.is_a?( ::Array::Hooked ).should == true
    hooked_array_two.should == [ :A ]
  end

  it 'can take elements via enumerator' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    enumerator = hooked_array.take_while
    enumerator.is_a?( Enumerator ).should == true
  end

  ##########
  #  to_a  #
  ##########

  it 'can return self' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    ( hooked_array.to_a == hooked_array ).should == true
  end

  ############
  #  to_ary  #
  ############

  it 'can return self' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    ( hooked_array.to_ary == hooked_array ).should == true
  end

  ##########
  #  to_s  #
  ##########

  it '#to_s is aliased to #inspect' do
    ::Array::Hooked.instance_method( :to_s ).should == ::Array::Hooked.instance_method( :inspect )
  end

  ###############
  #  transpose  #
  ###############

  it 'can transpose rows and columns' do
    hooked_array = ::Array::Hooked.new( nil, [ [1,2], [3,4], [5,6] ] )
    hooked_array_two = hooked_array.transpose
    hooked_array_two.is_a?( ::Array::Hooked ).should == true
    hooked_array_two.should == [ [1, 3, 5], [2, 4, 6] ]
  end

  ##########
  #  uniq  #
  ##########

  it 'can return a unique duplicate' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C, :C, :C, :B, :A ] )
    hooked_array_two = hooked_array.uniq
    hooked_array_two.is_a?( ::Array::Hooked ).should == true
    hooked_array_two.should == [ :A, :B, :C ]
  end

  it 'can return a unique duplicate by comparing block result' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C, :C, :C, :B, :A ] )
    hooked_array_two = hooked_array.uniq do |this_object|
      :A
    end
    hooked_array_two.is_a?( ::Array::Hooked ).should == true
    hooked_array_two.should == [ :A ]
  end

  ###########
  #  uniq!  #
  ###########

  it 'can remove non-unique elements' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C, :C, :C, :B, :A ] )
    hooked_array.uniq!
    hooked_array.should == [ :A, :B, :C ]
  end

  it 'can remove non-unique elements by comparing block result' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C, :C, :C, :B, :A ] )
    hooked_array.uniq! do |this_object|
      :A
    end
    hooked_array.should == [ :A ]
  end
  
  #############
  #  unshift  #
  #############

  it 'can unshift onto the first element' do
    hooked_array = ::Array::Hooked.new( nil, [ :A ] )
    hooked_array.unshift( :B )
    hooked_array.should == [ :B, :A ]
  end

  ###############
  #  values_at  #
  ###############

  it 'can return values at indexes or ranges' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C, :D, :E ] )
    hooked_array_two = hooked_array.values_at( 0, 3..4 )
    hooked_array_two.is_a?( ::Array::Hooked ).should == true
    hooked_array_two.should == [ :A, :D, :E ]
  end

  #########
  #  zip  #
  #########

  it 'can zip self' do
    hooked_array_one = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    hooked_array_two = ::Array::Hooked.new( nil, [ :D, :E, :F ] )
    zip_array = ::Array::Hooked.new( nil, [ 1, 2, 3 ] )
    zipped_array = zip_array.zip( hooked_array_one, hooked_array_two )  
    zipped_array.is_a?( ::Array::Hooked ).should == true
    ( zipped_array == [ [1, :A, :D], [2, :B, :E], [3, :C, :F] ] ).should == true
  end

  it 'can zip self and then run block' do
    hooked_array_one = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    hooked_array_two = ::Array::Hooked.new( nil, [ :D, :E, :F ] )
    zip_array = ::Array::Hooked.new( nil, [ 1, 2, 3 ] )
    block_ran = false
    zipped_array = zip_array.zip( hooked_array_one, hooked_array_two ) do
      block_ran = true
    end
    zipped_array.is_a?( ::Array::Hooked ).should == true
    ( zipped_array == [ [1, :A, :D], [2, :B, :E], [3, :C, :F] ] ).should == true
    block_ran.should == true
  end

  ############
  #  *splat  #
  ############
  
  it 'should call #to_a when splatted' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C, :D, :E ] )
    called_method = false
    hooked_array.define_singleton_method( :to_a ) do
      called_method = true
      super()
    end
    def empty_method( *splat )
    end
    empty_method( *hooked_array )
    called_method.should == true
  end

  ##################
  #  pre_set_hook  #
  ##################

  it 'has a hook that is called before setting a value; return value is used in place of object' do
    class ::Array::Hooked::SubMockPreSet < ::Array::Hooked
      def pre_set_hook( index, object, is_insert = false, length = nil )
        return :some_other_value
      end
    end
    hooked_array = ::Array::Hooked::SubMockPreSet.new
    hooked_array.push( :some_value )
    hooked_array.should == [ :some_other_value ]
  end

  ###################
  #  post_set_hook  #
  ###################

  it 'has a hook that is called after setting a value' do
    class ::Array::Hooked::SubMockPostSet < ::Array::Hooked
      def post_set_hook( index, object, is_insert = false, length = nil )
        return :some_other_value
      end
    end
    hooked_array = ::Array::Hooked::SubMockPostSet.new
    hooked_array.push( :some_value )
    hooked_array.should == [ :some_value ]
  end

  ##################
  #  pre_get_hook  #
  ##################

  it 'has a hook that is called before getting a value; if return value is false, get does not occur' do
    class ::Array::Hooked::SubMockPreGet < ::Array::Hooked
      def pre_get_hook( index, length = nil )
        return false
      end
    end
    hooked_array = ::Array::Hooked::SubMockPreGet.new
    hooked_array.push( :some_value )
    hooked_array[ 0 ].should == nil
    hooked_array.should == [ :some_value ]
  end

  ###################
  #  post_get_hook  #
  ###################

  it 'has a hook that is called after getting a value' do
    class ::Array::Hooked::SubMockPostGet < ::Array::Hooked
      def post_get_hook( index, object, length = nil )
        return :some_other_value
      end
    end
    hooked_array = ::Array::Hooked::SubMockPostGet.new
    hooked_array.push( :some_value )
    hooked_array[ 0 ].should == :some_other_value
    hooked_array.should == [ :some_value ]
  end

  #####################
  #  pre_delete_hook  #
  #####################

  it 'has a hook that is called before deleting an index; if return value is false, delete does not occur' do
    class ::Array::Hooked::SubMockPreDelete < ::Array::Hooked
      def pre_delete_hook( index, length = nil )
        return false
      end
    end
    hooked_array = ::Array::Hooked::SubMockPreDelete.new
    hooked_array.push( :some_value )
    hooked_array.delete_at( 0 )
    hooked_array.should == [ :some_value ]
  end

  ######################
  #  post_delete_hook  #
  ######################

  it 'has a hook that is called after deleting an index' do
    class ::Array::Hooked::SubMockPostDelete < ::Array::Hooked
      def post_delete_hook( index, object )
        return :some_other_value
      end
    end
    hooked_array = ::Array::Hooked::SubMockPostDelete.new
    hooked_array.push( :some_value )
    hooked_array.delete_at( 0 ).should == :some_other_value
    hooked_array.should == [ ]
  end
  
end
