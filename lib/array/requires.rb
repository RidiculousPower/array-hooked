
basepath = 'hooked'

files = [
  
  'array_interface'
  
]

files.each do |this_file|
  require_relative( File.join( basepath, this_file ) + '.rb' )
end
