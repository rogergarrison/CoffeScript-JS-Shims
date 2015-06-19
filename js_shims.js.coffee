# This program contains JavaScript shims/polyfills for modern JavaScript built-in functions and methods
# Object.keys(), [].indexOf(), [].reduce(), [].map, and [].forEach()
# Polyfill definitions found at https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects
# Converted to CoffeeScript by Roger Garrison

#add Object.keys
#found at https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/keys
# converted to coffeescript for my use
Object.keys ||= do ->
  'use strict'
  hasOwnProperty = Object::hasOwnProperty
  hasDontEnumBug = !`({ toString: null})`.propertyIsEnumerable 'toString'
  dontEnums = [
    'toString'
    'toLocaleString'
    'valueOf'
    'hasOwnProperty'
    'isPrototypeOf'
    'propertyIsEnumerable'
    'constructor'
  ]
  dontEnumsLength = dontEnums.length
  (obj) ->
    if typeof obj != 'object' and (!obj? or typeof obj != 'function')
      throw new TypeError 'object.keys called on non-object'
    result = []

    for prop of obj
      if hasOwnProperty.call obj, prop
        result.push prop

    if hasDontEnumbug?
      for num in [0...dontEnumsLength]
        if hasOwnProperty.call obj, dontEnums[num]
          result.push dontEnums[num]

    result



#add the Array.indexOf
#found at https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/indexOf
# converted to coffeescript for my use
Array::indexOf ||= (searchElement, fromIndex) ->
  unless this?
    throw new TypeError "Array.prototype.indexOf is called on null or not defined"

  O = Object this
  len = O.length >>> 0

  return -1 if len == 0

  n = +fromIndex || 0
  n = 0 if Math.abs(n) == Infinity

  k = Math.max (if n >= 0 then n else len - Math.abs(n)), 0
  for num in [k...len]
    return num if num of O and O[num] == searchElement

  return -1

# add the Array.reduce if it doesn't exist
#found at https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/Reduce?redirectlocale=en-US&redirectslug=JavaScript%2FReference%2FGlobal_Objects%2FArray%2FReduce#Polyfill
# converted to coffeescript for my use
Array::reduce ||= (callback) ->
  "use strict"

  unless this?
    throw new TypeError "Array.prototype.reduce called on null or undefined"

  unless typeof callback == 'function'
    throw new TypeError "#{callback}  is not a function"

  t = Object this
  len = t.length >>> 0
  k = 0

  value = if arguments.length == 2
    arguments[1]
  else
    k++ while k < len and not (k of t)
    throw new TypeError "Reduce of empty array with no initial value" if k >= len
    t[k++]

  for num in  [k...len]
    value = callback value, t[num], num, t

  return value


# add Array.map if it doesn't exist
# found at https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/map?redirectlocale=en-US&redirectslug=JavaScript%2FReference%2FGlobal_Objects%2FArray%2Fmap
# converted to coffeescript for my use
Array::map ||= (callback, thisArg) ->
  throw new TypeError "Array.prototrype.map is called on null or undefined" unless this?
  
  O = Object this
  len = O.length >>> 0
  throw new TypeError "#{callback} is not a function" unless typeof callback == "function"

  T = thisArg if arguments.length > 1
  A = new Array len
  for k in [0...len]
    if k of O
      kValue = O[k]
      mappedValue = callback.call T, kValue, k, O
      A[k] = mappedValue
  return A

# add the Array.forEach if it doesn't exist
#found at https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/forEach?redirectlocale=en-US&redirectslug=JavaScript%2FReference%2FGlobal_Objects%2FArray%2FforEach
# converted to coffeescript for my use
Array::forEach ||= (callback, thisArg) ->
  throw new TypeError "Array.prototype.forEach is called on null or undefined" unless this?

  O = Object this
  len = O.length >>> 0

  throw new TypeError "#{callback} is not a function" unless typeof callback == "function"

  T = thisArg if arguments.length > 1

  for k in [0...len]
    if k of O
      kValue = O[k]
      callback.call T, kValue, k, O


