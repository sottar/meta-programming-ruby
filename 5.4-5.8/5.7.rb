# 5.7

## alias
class Fixnum
  alias_method :old_plus, :+
  def +(val)
    self.old_plus(val).old_plus(1)
  end
end


## refinements
module PlusRefinements
  refine Fixnum do
    def +(val)
      super(val).super(1)
    end
  end
end

class C
  using PlusRefinements
  def print(val)
    1 + val
  end
end

obj = C.new
obj.print(10)


## prepend
module ExplicitPlus
  def +(val)
    super(val).super(1)
  end
end

Fixnum.class_eval do
  prepend ExplicitPlus
end

3+1