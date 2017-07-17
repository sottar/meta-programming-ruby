# 5.6
## 5.6.1
class MyClass
  def my_method; 'my_method()'; end
  alias_method :m, :my_method
end

obj = MyClass.new
obj.my_method # => "my_method()"
obj.m # => "my_method()"

### class_definitions/wrapper_around_alias.rb
class String
  alias_method :real_length, :length

  def length
    real_length > 5 ? 'long' : 'short'
  end
end

"War and Peace".length      # => "long"
"War and Peace".real_length # => 13

### gems/thor-0.17.0/bin/rake2thor
input = ARGV[0] || 'Rakefile'
$require = []

module Kernel
  def require_with_record(file)
    $require << file if caller[1] =~ /rake2thor:/
    require_without_record file
  end
  alias_method :require_without_record, :require
  alias_method :require, :require_with_record
end

load input

## 5.6.2
### class_definitions/wrapper_refinements.rb
module StringRefinements
  refine String do
    def length
      super > 5 ? 'long' : 'short'
    end
  end
end

using StringRefinements
"War and Peace".length

### class_definitions/wrapper_prepend.rb
module ExplicitString
  def length
    super > 5 ? 'long' : 'short'
  end
end

String.class_eval do
  prepend ExplicitString
end

"War and Peace".length   # => "long"
