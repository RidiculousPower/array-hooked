require 'date'

Gem::Specification.new do |spec|

  spec.name                      =  'hooked-array'
  spec.rubyforge_project         =  'hooked-array'
  spec.version                   =  '1.0.0'

  spec.summary                   =  "Provides ::Array::Hooked and ::HookedArray."
  spec.description               =  "A subclass of Array that offers event hooks for pre-insert/pre-set/pre-delete, insert/set/delete. ::HookedArray offers implicit reference to a configuration instance."

  spec.authors                   =  [ 'Asher' ]
  spec.email                     =  'asher@ridiculouspower.com'
  spec.homepage                  =  'http://rubygems.org/gems/hooked-array'

  spec.add_dependency            'identifies_as'

  spec.date                      =  Date.today.to_s
  
  spec.files                     = Dir[ '{lib,spec}/**/*',
                                        'README*', 
                                        'LICENSE*',
                                        'CHANGELOG*' ]

end
