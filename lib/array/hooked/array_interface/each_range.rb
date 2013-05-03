# -*- encoding : utf-8 -*-

module ::Array::Hooked::ArrayInterface::EachRange

  ################
  #  each_range  #
  ################
  
  ###
  # Iterates a range in self between index_one and index_two from left to right.
  #
  def each_range( range_start = 0, range_end = -1 )

    return to_enum unless block_given?
    
    element_count = nil
    range_start = range_start < 0 ? ( element_count = size ) + range_start : range_start
    range_end = range_end < 0 ? ( element_count || size ) + range_end : range_end

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
  def reverse_each_range( range_start = -1, range_end = 0 )

    return to_enum unless block_given?

    element_count = nil
    range_start = range_start < 0 ? ( element_count = size ) + range_start : range_start
    range_end = range_end < 0 ? ( element_count || size ) + range_end : range_end

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
