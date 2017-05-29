# 2.4 メソッドを呼び出すときに何が起きているの？

## 2.4.1 メソッド探索
class MyClass
  def my_method; 'my_method()';
end

class MySubClass < MyClass; end

obj = MySubClass.new
obj.my_method()

### モジュールとメソッド探索
module M1
  def my_method
    'M1#my_method()'
  end
end

class C
  include M1
end
class D < C; end
D.ancestors

class C2
  prepend M2
end
class D2 < C2; end
D2.ancestors  

### 多重インクルード
module M1; end

module M2
  include M1
end

module M3
  prepend M1
  include M2
end

M3.ancestors

## 2.4.2 メソッドの実行
def my_method
  temp = @x + 1
  my_other_method(temp)
end

### self キーワード
class MyClass
  def testing_self
    @val = 10
    my_method
    self
  end

  def my_method
    @val = @val + 1
  end
end

obj = MyClass.new
obj.testing_self 

### private の本当の意味
class C
  def public_method
    self.private_method
  end
  private
  def private_method;end
end
C.new.public_method

# ---------------------------
#スーパークラスから継承した private メソッドは呼び出せるか？
class ParentClass
  def public_method
    'public'
  end
  private
  def private_method
    'private'
  end
end

class SubClass < ParentClass
   def sub_public_method
    private_method
  end
end

a = SubClass.new
a.sub_public_method

## 2.4.3 Refinements
class String
  def to_alphanumeric
    gsub(/[^\w\s]/, '')
  end
end

# -------------------------
# alphanumeric.rb
module StringExtensions
  refine String do
    def to_alphanumeric
      gsub(/[^\w\s]/, '')
    end
  end
end


# -------------------------
# refinements_in_file
module StringExtensions
  refine String do
    def to_alphanumeric
      gsub(/[^\w\s]/, '')
    end
  end
end

"my *1st* refinement!".to_alphanumeric

# -------------------------
# refinements_in_module
module StringExtensions
  refine String do
    def reverse
      "esrever"
    end
  end
end

module StringStuff
  using StringExtensions
  "my_string".reverse
end

"my_string".reverse

### Refinements を捕まえた
class MyClass
  def my_method
    "original my_method"
  end
  def another_method
    my_method
  end
end

module MyClassRefinements
  refine MyClass do
    def my_method
      "refined my_method"
    end
  end
end

using MyClassRefinements
MyClass.new.my_method
MyClass.new.another_method
