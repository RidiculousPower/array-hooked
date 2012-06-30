# Hooked Array #

http://rubygems.org/gems/array-hooked

# Description #

Provides ::Array::Hooked and ::HookedArray.

# Summary #

A subclass of Array that offers event hooks for pre-insert/pre-set/pre-delete, insert/set/delete. ::HookedArray offers implicit reference to a configuration instance.

# Install #

* sudo gem install array-hooked

# Usage #

Provides methods that can be overridden that will be called during every corresponding event:

* pre_set_hook
* post_set_hook
* pre_get_hook
* post_get_hook
* pre_delete_hook
* post_delete_hook

As a result, several internal perform methods have been created:

* perform_set_between_hooks
* perform_insert_between_hooks
* perform_delete_between_hooks

Also provides methods corresponding to each already-existing method + '_without_hooks', which causes methods to bypass hooks.

# License #

  (The MIT License)

  Copyright (c) Asher

  Permission is hereby granted, free of charge, to any person obtaining
  a copy of this software and associated documentation files (the
  'Software'), to deal in the Software without restriction, including
  without limitation the rights to use, copy, modify, merge, publish,
  distribute, sublicense, and/or sell copies of the Software, and to
  permit persons to whom the Software is furnished to do so, subject to
  the following conditions:

  The above copyright notice and this permission notice shall be
  included in all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
  IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
  CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
  TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
  SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.