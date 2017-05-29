# 2.3 クイズ: 引かれていない線
class MyClass; end;
obj1 = MyClass.new
obj2 = MyClass.new

# 1, Object のクラスは？
Object.class

# 2, Module のスーパークラスは？
Module.superclass

# 3, Class のクラスは？
Class.class

# 4, このコードを実行した場合, Obj3 はどこ
obj3 = MyClass.new
obj3.instance_variable_set("@x" = 10)
