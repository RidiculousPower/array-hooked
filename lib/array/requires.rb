
basepath = 'hooked'

files = [
  
  'array_interface/hooks',
  'array_interface/undecorated',
  'array_interface/without_hooks',
  'array_interface/without_internal_array',
  'array_interface'
  
]

files.each do |this_file|
  require_relative( File.join( basepath, this_file ) + '.rb' )
end
