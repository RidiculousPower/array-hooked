
require 'identifies_as'

# namespaces that have to be declared ahead of time for proper load order
require_relative './namespaces'

# source file requires
require_relative './requires.rb'

class ::Array::Hooked < ::Array

  ###############################
  #  perform_set_between_hooks  #
  ###############################

  # Alias to original :[]= method. Used to perform actual set between hooks.
  # @param [Fixnum] index Index at which set is taking place.
  # @param [Object] object Element being set.
  # @return [Object] Element returned.
  alias_method :perform_set_between_hooks, :[]=

  ##################################
  #  perform_insert_between_hooks  #
  ##################################

  # Alias to original :insert method. Used to perform actual insert between hooks.
  # @param [Fixnum] index Index at which insert is taking place.
  # @param [Array<Object>] objects Elements being inserted.
  # @return [Object] Element returned.
  alias_method :perform_insert_between_hooks, :insert

  ##################################
  #  perform_delete_between_hooks  #
  ##################################

  # Alias to original :delete method. Used to perform actual delete between hooks.
  # @param [Fixnum] index Index at which delete is taking place.
  # @return [Object] Element returned.
  alias_method :perform_delete_between_hooks, :delete_at
  
  include ::Array::Hooked::ArrayInterface
  
end
