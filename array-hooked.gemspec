require 'date'

Gem::Specification.new do |spec|

  spec.name                      =  'array-hooked'
  spec.rubyforge_project         =  'array-hooked'
  spec.version                   =  '1.2.0'

  spec.summary                   =  "Provides ::Array::Hooked."
  spec.description               =  "A subclass of Array that offers event hooks for pre-insert/pre-set/pre-delete, insert/set/delete and a reference to a configuration instance that owns the Array instance."

  spec.authors                   =  [ 'Asher' ]
  spec.email                     =  'asher@ridiculouspower.com'
  spec.homepage                  =  'http://rubygems.org/gems/array-hooked'

  spec.add_dependency            'identifies_as'

  spec.date                      = Date.today.to_s
  
  spec.files                     = Dir[ '{lib,lib_ext,spec}/**/*',
                                        'README*', 
                                        'LICENSE*',
                                        'CHANGELOG*' ]

end
