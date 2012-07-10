
require 'identifies_as'

# namespaces that have to be declared ahead of time for proper load order
require_relative './namespaces'

# source file requires
require_relative './requires.rb'

class ::Array::Hooked < ::Array

  #####################
  #  undecorated_set  #
  #####################

  # Alias to original :[]= method. Used to perform actual set between hooks.
  # @param [Fixnum] index Index at which set is taking place.
  # @param [Object] object Element being set.
  # @return [Object] Element returned.
  alias_method :undecorated_set, :[]=

  #####################
  #  undecorated_get  #
  #####################

  # Alias to original :[]= method. Used to perform actual set between hooks.
  # @param [Fixnum] index Index at which set is taking place.
  # @param [Object] object Element being set.
  # @return [Object] Element returned.
  alias_method :undecorated_get, :[]
  
  ########################
  #  undecorated_insert  #
  ########################

  # Alias to original :insert method. Used to perform actual insert between hooks.
  # @param [Fixnum] index Index at which insert is taking place.
  # @param [Array<Object>] objects Elements being inserted.
  # @return [Object] Element returned.
  alias_method :undecorated_insert, :insert
  
  ###########################
  #  undecorated_delete_at  #
  ###########################

  # Alias to original :delete method. Used to perform actual delete between hooks.
  # @param [Fixnum] index Index at which delete is taking place.
  # @return [Object] Element returned.
  alias_method :undecorated_delete_at, :delete_at

  include ::Array::Hooked::ArrayInterface
  
end
