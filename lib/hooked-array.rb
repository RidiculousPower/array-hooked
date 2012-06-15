
require 'identifies_as'

class ::Array::Hooked < ::Array
end
class ::HookedArray < ::Array::Hooked
end

basepath = 'hooked-array/Array/Hooked'

files = [
    
]

second_basepath = 'hooked-array/HookedArray'

second_files = [
  
  'Interface'
  
]

files.each do |this_file|
  require_relative( File.join( basepath, this_file ) + '.rb' )
end
second_files.each do |this_file|
  require_relative( File.join( second_basepath, this_file ) + '.rb' )
end

require_relative( basepath + '.rb' )
require_relative( second_basepath + '.rb' )
