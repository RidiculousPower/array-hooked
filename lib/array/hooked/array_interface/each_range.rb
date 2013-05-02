# -*- encoding : utf-8 -*-

module ::Array::Hooked::ArrayInterface::EachRange

  ################
  #  each_range  #
  ################
  
  ###
  # Iterates a range in self between index_one and index_two from left to right.
  #
  def each_range( index_one, index_two = -1 )

    return to_enum unless block_given?
    
    element_count = nil
    index_one = index_one < 0 ? ( element_count = size ) + index_one : index_one
    index_two = index_two < 0 ? ( element_count || size ) + index_two : index_two

    range_start = nil
    range_end = nil
    
    # renumber local => parent in range
    if index_one < index_two
      range_start = index_one
      range_end = index_two
    else
      range_start = index_two
      range_end = index_one
    end
    
    # copy parent => local to local => parent as appropriate
    number_of_indexes_modified = range_end - range_start + 1
    number_of_indexes_modified.times do |this_time|
      this_index = range_start + this_time
      this_object = self[ this_index ]
      yield( this_object, this_index )
    end
    
    return self
    
  end

  ########################
  #  reverse_each_range  #
  ########################
  
  ###
  # Iterates a range in self between index_one and index_two from right to left.
  #
  def reverse_each_range( index_one = -1, index_two = 0 )

    return to_enum unless block_given?

    element_count = nil
    index_one = index_one < 0 ? ( element_count = size ) + index_one : index_one
    index_two = index_two < 0 ? ( element_count || size ) + index_two : index_two

    range_start = nil
    range_end = nil
    
    # renumber local => parent in range
    if index_one < index_two
      range_start = index_two
      range_end = index_one
    else
      range_start = index_one
      range_end = index_two
    end
    
    # copy parent => local to local => parent as appropriate
    number_of_indexes_modified = range_start - range_end + 1
    number_of_indexes_modified.times do |this_time|
      this_index = range_start - this_time
      this_object = self[ this_index ]
      yield( this_object, this_index )
    end
    
    return self

  end
  
end
