
require 'identifies_as'
require 'module/cluster'

# namespaces that have to be declared ahead of time for proper load order
require_relative './namespaces'

# source file requires
require_relative './requires.rb'

class ::Array::Hooked < ::Array

  include ::Array::Hooked::ArrayInterface
  
end
