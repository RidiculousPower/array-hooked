
require_relative '../../lib/array-hooked.rb'

################
#  initialize  #
################

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
  
end

######################################
#  self.class::WithoutInternalArray  #
######################################

describe ::Array::Hooked do

  it 'should have a subclass self.class::WithoutInternalArray for internal duplication, which initialize without creating the internal array' do
    array_without_internal_array = ::Array::Hooked::WithoutInternalArray.new
    array_without_internal_array.internal_array.should == nil
  end
    
end

describe ::Array::Hooked do

  #######
  #  +  #
  #######

  it 'can + elements' do
    hooked_array = ::Array::Hooked.new
    hooked_array += [ :A ]
    hooked_array.should == [ :A ]
  end


  #######
  #  -  #
  #######
  
  it 'can - an array' do
    hooked_array = ::Array::Hooked.new( nil, [ :A ] )
    hooked_array -= [ :A ]
    hooked_array.should == [ ]
  end

  ########
  #  <<  #
  ########

  it 'can add elements' do
    hooked_array = ::Array::Hooked.new
    hooked_array << :A
    hooked_array.should == [ :A ]
  end

  #######
  #  &  #
  #######

  #######
  #  *  #
  #######

  #########
  #  <=>  #
  #########

  ########
  #  ==  #
  ########

  #######
  #  |  #
  #######

  ###########
  #  assoc  #
  ###########

  ##############
  #  collect!  #
  ##############

  it 'can replace by collect/map' do

    hooked_array = ::Array::Hooked.new

    hooked_array.push( :A, :B, :C )
    hooked_array.should == [ :A, :B, :C ]
    hooked_array.collect! { :C }
    hooked_array.should == [ :C, :C, :C ]

    hooked_array.collect!.is_a?( Enumerator ).should == true

  end

  ##########
  #  map!  #
  ##########

  #############
  #  collect  #
  #############

  #################
  #  combination  #
  #################

  ##############
  #  compact!  #
  ##############

  it 'can compact' do

    hooked_array = ::Array::Hooked.new

    hooked_array.push( :A, nil, :B, nil, :C, nil )
    hooked_array.should == [ :A, nil, :B, nil, :C, nil ]
    hooked_array.compact!
    hooked_array.should == [ :A, :B, :C ]

  end

  #############
  #  compact  #
  #############

  ###########
  #  count  #
  ###########

  ###########
  #  cycle  #
  ###########

  ##########
  #  drop  #
  ##########

  ################
  #  drop_while  #
  ################

  ##########
  #  each  #
  ##########

  ################
  #  each_index  #
  ################

  ############
  #  empty?  #
  ############

  ###########
  #  fetch  #
  ###########

  ##########
  #  fill  #
  ##########

  ################
  #  find_index  #
  ################

  ###########
  #  index  #
  ###########

  ###########
  #  first  #
  ###########

  ##############
  #  flatten!  #
  ##############

  it 'can flatten' do

    hooked_array = ::Array::Hooked.new

    hooked_array.push( :A, [ :F_A, :F_B ], :B, [ :F_C ], :C, [ :F_D ], [ :F_E ] )
    hooked_array.should == [ :A, [ :F_A, :F_B ], :B, [ :F_C ], :C, [ :F_D ], [ :F_E ] ]
    hooked_array.flatten!
    hooked_array.should == [ :A, :F_A, :F_B, :B, :F_C, :C, :F_D, :F_E ]

  end

  #############
  #  flatten  #
  #############

  ############
  #  freeze  #
  ############

  ##########
  #  hash  #
  ##########

  ##############
  #  include?  #
  ##############

  #############
  #  inspect  #
  #############

  ##########
  #  join  #
  ##########

  ##########
  #  last  #
  ##########

  ############
  #  length  #
  ############

  #########
  #  map  #
  #########

  ##########
  #  pack  #
  ##########

  #################
  #  permutation  #
  #################

  #############
  #  product  #
  #############

  ############
  #  rassoc  #
  ############

  #############
  #  reject!  #
  #############

  it 'can reject' do

    hooked_array = ::Array::Hooked.new

    hooked_array.push( :A, :B, :C )
    hooked_array.should == [ :A, :B, :C ]
    hooked_array.reject! do |object|
      object != :C
    end
    hooked_array.should == [ :C ]

  end

  ############
  #  reject  #
  ############

  ##########################
  #  repeated_combination  #
  ##########################

  ##########################
  #  repeated_permutation  #
  ##########################

  ##############
  #  reverse!  #
  ##############

  it 'can reverse self' do

    hooked_array = ::Array::Hooked.new

    hooked_array.push( :A, :B, :C )
    hooked_array.should == [ :A, :B, :C ]
    hooked_array.reverse!
    hooked_array.should == [ :C, :B, :A ]

  end

  #############
  #  reverse  #
  #############

  ##################
  #  reverse_each  #
  ##################

  ############
  #  rindex  #
  ############

  #############
  #  rotate!  #
  #############

  it 'can rotate self' do

    hooked_array = ::Array::Hooked.new

    hooked_array.push( :A, :B, :C )
    hooked_array.should == [ :A, :B, :C ]

    hooked_array.rotate!
    hooked_array.should == [ :B, :C, :A ]

    hooked_array.rotate!( -1 )
    hooked_array.should == [ :A, :B, :C ]

  end

  ############
  #  rotate  #
  ############

  ############
  #  sample  #
  ############

  #############
  #  select!  #
  #############

  it 'can keep by select' do

    hooked_array = ::Array::Hooked.new

    hooked_array.push( :A, :B, :C )
    hooked_array.should == [ :A, :B, :C ]
    hooked_array.select! do |object|
      object == :C
    end
    hooked_array.should == [ :C ]

    hooked_array.select!.is_a?( Enumerator ).should == true

  end

  ############
  #  select  #
  ############

  ##############
  #  shuffle!  #
  ##############

  it 'can shuffle self' do

    hooked_array = ::Array::Hooked.new

    hooked_array.push( :A, :B, :C )
    hooked_array.should == [ :A, :B, :C ]

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

  #############
  #  shuffle  #
  #############

  ############
  #  length  #
  ############

  ##########
  #  size  #
  ##########

  ############
  #  slice!  #
  ############
  
  it 'can slice elements' do
    hooked_array = ::Array::Hooked.new( nil, [ :A ])
    hooked_array.slice!( 0, 1 ).should == [ :A ]
    hooked_array.should == [ ]
  end
  
  ###########
  #  slice  #
  ###########

  ###########
  #  sort!  #
  ###########

  it 'can replace by collect/map' do

    hooked_array = ::Array::Hooked.new

    hooked_array.push( :A, :B, :C )
    hooked_array.should == [ :A, :B, :C ]
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

  ##########
  #  sort  #
  ##########

  ##############
  #  sort_by!  #
  ##############

  it 'can replace by collect/map' do

    hooked_array = ::Array::Hooked.new

    hooked_array.push( :A, :B, :C )
    hooked_array.should == [ :A, :B, :C ]
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

  ##########
  #  take  #
  ##########

  ################
  #  take_while  #
  ################

  ##########
  #  to_a  #
  ##########

  ############
  #  to_ary  #
  ############

  ##########
  #  to_s  #
  ##########

  ###############
  #  transpose  #
  ###############

  ###########
  #  uniq!  #
  ###########

  it 'can remove non-unique elements' do

    hooked_array = ::Array::Hooked.new

    hooked_array.push( :A, :B, :C, :C, :C, :B, :A )
    hooked_array.should == [ :A, :B, :C, :C, :C, :B, :A ]
    hooked_array.uniq!
    hooked_array.should == [ :A, :B, :C ]

  end

  ##########
  #  uniq  #
  ##########

  ###############
  #  values_at  #
  ###############

  #########
  #  zip  #
  #########

  ########
  #  []  #
  ########

  ########
  #  at  #
  ########

  #########
  #  []=  #
  #########

  it 'can store elements' do
  
    hooked_array = ::Array::Hooked.new

    hooked_array[ 0 ] = :A
    hooked_array.should == [ :A ]

    hooked_array[ 1 ] = :B
    hooked_array.should == [ :A, :B ]

    hooked_array[ 0 ] = :D
    hooked_array.should == [ :D, :B ]

  end

  ################
  #  hooked_set  #
  ################

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

  ##########
  #  push  #
  ##########

  ############
  #  concat  #
  ############

  it 'can concat elements' do
    hooked_array = ::Array::Hooked.new
    hooked_array.concat( [ :A ] )
    hooked_array.should == [ :A ]
  end

  ############
  #  delete  #
  ############
  
  it 'can delete elements' do

    hooked_array = ::Array::Hooked.new

    hooked_array.push( :A )
    hooked_array.should == [ :A ]

    hooked_array.delete( :A )
    hooked_array.should == [ ]

    hooked_array.push( :B )
    hooked_array.should == [ :B ]

  end

  ###################
  #  hooked_delete  #
  ###################

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

    hooked_array = ::Array::Hooked.new

    hooked_array.push( :A )
    hooked_array.should == [ :A ]
    
    hooked_array.delete_at( 0 )
    hooked_array.should == [ ]

    hooked_array.push( :B )
    hooked_array.should == [ :B ]

  end

  #######################
  #  delete_at_indexes  #
  #######################

  it 'can delete by indexes' do

    hooked_array = ::Array::Hooked.new

    hooked_array.push( :A, :B, :C )
    hooked_array.should == [ :A, :B, :C ]

    hooked_array.delete_at_indexes( 0, 1 )
    hooked_array.should == [ :C ]

  end

  ###############
  #  delete_if  #
  ###############

  it 'can delete by block' do

    hooked_array = ::Array::Hooked.new

    hooked_array.push( :A, :B, :C )
    hooked_array.should == [ :A, :B, :C ]
    hooked_array.delete_if do |object|
      object != :C
    end
    hooked_array.should == [ :C ]

    hooked_array.delete_if.is_a?( Enumerator ).should == true

  end

  #############
  #  keep_if  #
  #############

  it 'can keep by block' do

    hooked_array = ::Array::Hooked.new

    hooked_array.push( :A, :B, :C )
    hooked_array.should == [ :A, :B, :C ]
    hooked_array.keep_if do |object|
      object == :C
    end
    hooked_array.should == [ :C ]

  end

  #############
  #  replace  #
  #############

  it 'can replace self' do

    hooked_array = ::Array::Hooked.new

    hooked_array.push( :A, :B, :C )
    hooked_array.should == [ :A, :B, :C ]
    hooked_array.replace( [ :D, :E, :F ] )
    hooked_array.should == [ :D, :E, :F ]

  end

  #############
  #  unshift  #
  #############

  it 'can unshift onto the first element' do
    hooked_array = ::Array::Hooked.new( nil, [ :A ] )
    hooked_array.unshift( :B )
    hooked_array.should == [ :B, :A ]
  end

  #########
  #  pop  #
  #########
  
  it 'can pop the final element' do

    hooked_array = ::Array::Hooked.new( nil, [ :A ] )
    hooked_array.pop.should == :A
    hooked_array.should == [ ]
  end

  ###########
  #  shift  #
  ###########
  
  it 'can shift the first element' do
    hooked_array = ::Array::Hooked.new( nil, [ :A ] )
    hooked_array.shift.should == :A
    hooked_array.should == [ ]
  end

  ###########
  #  clear  #
  ###########

  it 'can clear, causing present elements to be excluded' do
    hooked_array = ::Array::Hooked.new( nil, [ :A ] )
    hooked_array.clear
    hooked_array.should == [ ]
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
