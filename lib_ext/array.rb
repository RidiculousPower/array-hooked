# -*- encoding : utf-8 -*-

class ::Array
  
  SortBlock = ::Proc.new { |a, b| a <=> b }
  ReverseSortBlock = ::Proc.new { |a, b| - ( a <=> b ) }

  include ::Array::Hooked::ArrayInterface::EachRange

end
