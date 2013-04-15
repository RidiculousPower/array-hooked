# -*- encoding : utf-8 -*-

class ::Array::Hooked::Exception::IndexOffsetError < ::ArgumentError
  
  ################
  #  initialize  #
  ################
  
  def initialize( array, index_offset )
    
    message = 'Cannot convert index offset ' << index_offset.to_s << ', as it is beyond the bounds of array size (' << 
              array.size.to_s << ': '<< array.to_s << ').'
    
    super( message )
    
  end
  
end
