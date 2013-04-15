# -*- encoding : utf-8 -*-

require 'forwardable'

basepath = 'hooked'

files = [
  
  'array_interface/class_instance',
  'array_interface/array_methods',
  'array_interface/additional_methods',
  'array_interface/hooks',
  'array_interface/undecorated',
  'array_interface/without_hooks',
  'array_interface/without_internal_array',
  'array_interface',
  
  'exception/index_offset_error'
  
]

files.each { |this_file| require_relative( ::File.join( basepath, this_file ) << '.rb' ) }
