# -*- encoding : utf-8 -*-

require 'forwardable'

[

  'hooked/array_interface/class_instance',
  'hooked/array_interface/array_methods',
  'hooked/array_interface/additional_methods',
  'hooked/array_interface/hooks',
  'hooked/array_interface/undecorated',
  'hooked/array_interface/without_hooks',
  'hooked/array_interface/each_range',
  'hooked/array_interface',
  
  '../../lib_ext/array',
  
  'hooked/exception/index_offset_error'
  
].each { |this_file| require_relative( this_file << '.rb' ) }
