
## 6/14/2012 ##

Initial release - split from compositing-array. 

## 6/15/2012 ##

Added missing :get_without_hooks and corresponding hooks.

## 6/30/2012 ##

Renamed from hooked-array to array-hooked. File schema updated to reflect gem name.

## 7/4/2012 ##

Updated to use module-cluster to ensure interface encapsulation.

## 7/9/2012 ##

Removed module-cluster dependency.

## 7/10/2012 ##

Reverted module-cluster dependency.

## 11/24/2012 ##

Updated for fake Array inheritance support since inheriting from Array prevents #to_a from being called at splat.
