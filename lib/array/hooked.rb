# -*- encoding : utf-8 -*-

require 'identifies_as'

# namespaces that have to be declared ahead of time for proper load order
require_relative './namespaces'

# source file requires
require_relative './requires.rb'

class ::Array::Hooked

  include ::Array::Hooked::ArrayInterface
  extend ::Array::Hooked::ArrayInterface::ClassInstance
  
end
