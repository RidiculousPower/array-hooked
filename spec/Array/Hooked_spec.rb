
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
  
  ########
  #  ==  #
  ########
  
  it 'can == another array' do
    pending
  end

  #########
  #  <=>  #
  #########
  
  it 'can <=> another array' do
    
  end
  
  #######
  #  +  #
  #######

  it 'can + another array' do
    hooked_array = ::Array::Hooked.new
    hooked_array += [ :A ]
    hooked_array.should == [ :A ]
  end
  
  #######
  #  -  #
  #######
  
  it 'can - another array' do
    hooked_array = ::Array::Hooked.new( nil, [ :A ] )
    hooked_array -= [ :A ]
    hooked_array.should == [ ]
  end

  #######
  #  *  #
  #######
  
  it 'can * by an integer' do
    pending
  end

  it 'can * by a string' do
    pending
  end
  
  #######
  #  &  #
  #######
  
  it 'can & another array' do
    pending
  end

  #######
  #  |  #
  #######
  
  it 'can | another array' do
    pending
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
    pending
  end

  it 'can retrieve elements with a start index and a length' do
    pending
  end

  it 'can retrieve elements with a range' do
    pending
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
    pending
  end

  it 'can store elements with a range' do
    pending
  end

  ################
  #  hooked_set  #
  ################
  
  it 'aliases set for direct calling from subclasses' do
    pending
  end

  ###########
  #  assoc  #
  ###########

  it 'can assoc search' do
    pending
  end

  ########
  #  at  #
  ########

  it 'aliases []' do
    pending
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
    pending
  end

  it 'can collect with an enumerator' do
    pending
  end

  ##############
  #  collect!  #
  ##############
  
  it 'can replace by collect with a block' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    hooked_array.collect! { :C }
    hooked_array.should == [ :C, :C, :C ]
    hooked_array.collect!.is_a?( Enumerator ).should == true
  end

  it 'can replace by collect with an enumerator' do
  end

  #################
  #  combination  #
  #################

  it 'can yield combinations with a block' do
    pending
  end


  it 'can replace by collect with an enumerator' do
  end

  #############
  #  compact  #
  #############

  it 'can compact' do
    pending
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
    pending
  end

  it 'can count elements matching object' do
    pending
  end

  it 'can count elements for which block is true' do
    pending
  end

  ###########
  #  cycle  #
  ###########

  it 'repeatedly cycle a block' do
    pending
  end

  it 'repeatedly cycle via enumerator' do
    pending
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
    pending
  end

  ###################
  #  hooked_delete  #
  ###################

  it 'aliases delete for direct calling from subclasses' do
    pending
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
    hooked_array.delete_if.is_a?( Enumerator ).should == true
  end

  it 'can delete by enumerator' do
  end
  
  ##########
  #  drop  #
  ##########

  it 'can drop elements' do
    pending
  end

  ################
  #  drop_while  #
  ################

  it 'can drop elements for a block' do
    pending
  end

  it 'can drop elements for enumerator' do
    pending
  end

  ##########
  #  each  #
  ##########

  it 'can iterate for a block' do
    pending
  end

  it 'can iterate for enumerator' do
    pending
  end

  ################
  #  each_index  #
  ################

  it 'can iterate indexes for a block' do
    pending
  end

  it 'can iterate indexes for enumerator' do
    pending
  end

  ############
  #  empty?  #
  ############

  it 'can report if empty' do
    pending
  end

  ##########
  #  eql?  #
  ##########

  it 'can report it is the same instance or has the same contents' do
    pending
  end

  ###########
  #  fetch  #
  ###########

  it 'can fetch an index' do
    pending
  end

  it 'can fetch an index or return a default value' do
    pending
  end

  it 'can fetch an index or return a default value from a block' do
    pending
  end

  ##########
  #  fill  #
  ##########

  it 'can fill indexes with an object' do
    pending
  end

  it 'can fill indexes with an object from a start index for a length' do
    pending
  end

  it 'can fill a range with an object' do
    pending
  end

  it 'can fill with a block' do
    pending
  end

  it 'can fill from a start index for a length with a block' do
    pending
  end

  it 'can fill a range with a block' do
    pending
  end

  ################
  #  find_index  #
  ################

  it 'can find an index for an object' do
    pending
  end

  it 'can find an index for a block' do
    pending
  end

  it 'can find an index for enumerator' do
    pending
  end

  ###########
  #  index  #
  ###########

  it 'aliases #index to #find_index' do
    pending
  end

  ###########
  #  first  #
  ###########

  it 'can get the first element' do
    pending
  end

  it 'can get the first n elements' do
    pending
  end

  #############
  #  flatten  #
  #############

  it 'can flatten' do
    pending
  end

  it 'can flatten to n depth' do
    pending
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
  end
  
  ############
  #  freeze  #
  ############

  it 'can freeze' do
    pending
  end

  ##########
  #  hash  #
  ##########

  it 'two arrays with same content have the same hash' do
    pending
  end

  ##############
  #  include?  #
  ##############

  it 'can report if an object is included in array' do
    pending
  end

  #############
  #  inspect  #
  #############

  it 'can output as string' do
    pending
  end

  ##########
  #  join  #
  ##########

  it 'can join elements with no separation' do
    pending
  end

  it 'can join with string' do
    pending
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
  end

  ##########
  #  last  #
  ##########

  it 'can return last object' do
    pending
  end

  it 'can return last n objects' do
    pending
  end

  ############
  #  length  #
  ############

  it 'can report length/size' do
    pending
  end

  #########
  #  map  #
  #########

  it 'can collect/map by block' do
    pending
  end

  it 'can collect/map by enumerator' do
    pending
  end

  ##########
  #  map!  #
  ##########

  it 'can replace self by collect/map by block' do
    pending
  end

  it 'can replace self by collect/map by enumerator' do
    pending
  end

  ##########
  #  pack  #
  ##########

  it 'can pack via template string' do
    pending
  end

  #################
  #  permutation  #
  #################

  it 'can return permutations by block' do
    pending
  end

  it 'can return permutations by enumerator' do
    pending
  end
  
  it 'can return a number of permutations by block' do
    pending
  end
  
  it 'can return a number of permutations by enumerator' do
    pending
  end

  #########
  #  pop  #
  #########
  
  it 'can pop the final element' do
    hooked_array = ::Array::Hooked.new( nil, [ :A ] )
    hooked_array.pop.should == :A
    hooked_array.should == [ ]
  end

  it 'can pop the final n elements' do
  end

  #############
  #  product  #
  #############

  it 'can return all products of arrays' do
    pending
  end

  it 'can return self after processing all products of arrays with block' do
    pending
  end

  ##########
  #  push  #
  ##########

  it 'can append object(s) to end of array' do
    pending
  end

  ############
  #  rassoc  #
  ############

  it 'can right associative search' do
    pending
  end

  ############
  #  reject  #
  ############

  it 'can reject elements by block' do
    pending
  end

  it 'can reject elements by enumerator' do
    pending
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
  end
  
  ##########################
  #  repeated_combination  #
  ##########################

  it 'can do repeated combination by block' do
    pending
  end

  it 'can do repeated combination by enumerator' do
    pending
  end

  ##########################
  #  repeated_permutation  #
  ##########################

  it 'can do repeated permutation by block' do
    pending
  end

  it 'can do repeated permutation by enumerator' do
    pending
  end

  #############
  #  replace  #
  #############

  it 'can replace self' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    hooked_array.replace( [ :D, :E, :F ] )
    hooked_array.should == [ :D, :E, :F ]

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
    pending
  end

  #############
  #  reverse  #
  #############

  it 'can return a duplicate of self, reversed' do
    pending
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
    pending
  end

  it 'can iterate backwards with an enumerator' do
    pending
  end

  ############
  #  rindex  #
  ############

  it 'can return last index matching object' do
    pending
  end

  it 'can return last index matching block' do
    pending
  end

  it 'can return last index matching enumerator' do
    pending
  end

  ############
  #  rotate  #
  ############

  it 'can return a duplicate of self rotated' do
    pending
  end

  #############
  #  rotate!  #
  #############

  it 'can rotate self' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    hooked_array.rotate!
    hooked_array.should == [ :B, :C, :A ]
    hooked_array.rotate!( -1 )
    hooked_array.should == [ :A, :B, :C ]
  end

  ############
  #  sample  #
  ############

  it 'can sample an object' do
    pending
  end

  it 'can sample with a random number generator' do
    pending
  end

  it 'can sample n elements' do
    pending
  end

  it 'can sample n elements with a random number generator' do
    pending
  end

  ############
  #  select  #
  ############

  it 'can select items using a block' do
    pending
  end

  it 'can select items using an enumerator' do
    pending
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
    hooked_array.select!.is_a?( Enumerator ).should == true
  end

  it 'can keep by select with enumerator' do
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
  end
  
  #############
  #  shuffle  #
  #############

  it 'can return shuffled duplicate' do
    pending
  end

  it 'can return shuffled duplicate using random number generator' do
    pending
  end

  ##############
  #  shuffle!  #
  ##############

  it 'can shuffle self' do
    hooked_array = ::Array::Hooked.new( nil, [ :A, :B, :C ] )
    prior_version = hooked_array.dup
    attempts = [ ]
    50.times do
      hooked_array.shuffle!
      attempts.push( hooked_array == prior_version )
      prior_version = hooked_array.dup
    end
    attempts_correct = attempts.select { |member| member == false }.count
    ( attempts_correct >= 10 ).should == true
    first_shuffle_version = hooked_array
  end

  it 'can shuffle self with a random number generator' do
  end
  
  ##########
  #  size  #
  ##########

  it 'aliases #length as #size' do
    pending
  end

  ###########
  #  slice  #
  ###########

  it 'can slice an index' do
    pending
  end

  it 'can slice from a start index for a length' do
    pending
  end
  
  it 'can slice a range' do
    pending
  end

  ############
  #  slice!  #
  ############
  
  it 'can slice an index' do
    pending
  end
  
  it 'can slice from a start index for a length' do
    hooked_array = ::Array::Hooked.new( nil, [ :A ])
    hooked_array.slice!( 0, 1 ).should == [ :A ]
    hooked_array.should == [ ]
  end

  it 'can slice a range' do
    pending
  end
  
  ##########
  #  sort  #
  ##########

  it 'can return a sorted duplicate' do
    pending
  end

  it 'can return a duplicate sorted by a block' do
    pending
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
    hooked_array.sort!
    hooked_array.should == [ :A, :B, :C ]
  end

  it 'can sort self by enumerator' do
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
    hooked_array.sort_by!.is_a?( Enumerator ).should == true
  end

  it 'can sort itself by result provided by enumerator' do
  end
  
  ##########
  #  take  #
  ##########

  it 'can take n elements' do
    pending
  end

  ################
  #  take_while  #
  ################

  it 'can take elements via block until block returns false' do
    pending
  end

  it 'can take elements via enumerator' do
    pending
  end

  ##########
  #  to_a  #
  ##########

  it 'can return self' do
    pending
  end

  ############
  #  to_ary  #
  ############

  it 'can return self' do
    pending
  end

  ##########
  #  to_s  #
  ##########

  it '#to_s is aliased to #inspect' do
    pending
  end

  ###############
  #  transpose  #
  ###############

  it 'can transpose rows and columns' do
    pending
  end

  ##########
  #  uniq  #
  ##########

  it 'can return a unique duplicate' do
    pending
  end

  it 'can return a unique duplicate by comparing block result' do
    pending
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
    pending
  end

  #########
  #  zip  #
  #########

  it 'can zip self' do
    pending
  end

  it 'can zip self and then run block' do
    pending
  end

  ############
  #  *splat  #
  ############
  
  it 'should call #to_a when splatted' do
    
  end

  ##################
  #  pre_set_hook  #
  ##################

  it 'has a hook that is called before setting a value; return value is used in place of object' do
    class ::Array::Hooked::SubMockPreSet < ::Array::Hooked
      def pre_set_hook( index, object, is_insert = false )
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
      def post_set_hook( index, object, is_insert = false )
        return :some_other_value
      end
    end
    hooked_array = ::Array::Hooked::SubMockPostSet.new
    hooked_array.push( :some_value ).should == [ :some_other_value ]
    hooked_array.should == [ :some_value ]
  end

  ##################
  #  pre_get_hook  #
  ##################

  it 'has a hook that is called before getting a value; if return value is false, get does not occur' do
    class ::Array::Hooked::SubMockPreGet < ::Array::Hooked
      def pre_get_hook( index )
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
      def post_get_hook( index, object )
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
      def pre_delete_hook( index )
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
