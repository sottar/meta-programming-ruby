# 5.4 特異クラス
## 5.4.1
class MyClass
  def my_method; end
end

obj = MyClass.new
obj.my_method

### 特異メソッドを定義
def obj.my_singleton_method; end

## 5.4.2
class << an_object
  # your code
end

obj = Object.new

singleton_class = class << obj
  self
end

singleton_class.class # => Class

"abc".singleton_class # => #<Class:#<String:0x007fd8ee820e78>>

## 5.4.3
class C
  def a_method
    'C#a_method()'
  end
end

class D < C; end
obj = C.new
obj.a_method # => 'C#a_method()'

### 特異メソッドの追加
class << obj
  def a_singleton_method
    'obj#a_singleton_method()'
  end
end

obj.singleton_class.superClass

## 5.4.4
class C
  class << self
    def a_class_method]
      'C.a_class_method()'
    end
  end
end

C.singleton_class
D.singleton_class
D.singleton_class.superClass
C.singleton_class.superClass

