/*:
 ### **Singleton**
 ---
 
 [回到列表](Index)
 
 1. 定义:组合模式,将对象以树形结构组织起来，以达成“部分－整体”的层次结构，使得客户端对单个对象和组合对象的使用具有一致性。使用组合模式的环境为：在设计中想表示对象的“部分－整体”层次结构；希望用户忽略组合对象与单个对象的不同，统一地使用组合结构中的所有对象。
 2. 问题:需要实现一个画图功能，能画正方形和圆形，画板能够容纳正方形、圆形及画板。
 3. 解决方案:组合模式一般包含三个角色：抽象构件角色Component：它为组合中的对象声明接口，也可以为共有接口实现缺省行为。树叶构件角色Leaf：在组合中表示叶节点对象——没有子节点，实现抽象构件角色声明的接口。树枝构件角色Composite：在组合中表示分支节点对象——有子节点，实现抽象构件角色声明的接口；存储子部件。
 4. 使用方法：
     1. 定义抽象组件 Shape，注意某些方法可能在叶子节点没有用（这是组合模式的透明模式，统一接口，另外还有安全模式，有兴趣的自查）。
     2. 定义叶子节点 Square、Circle。
     3. 定义树枝节点 Whiteboard,注意树枝节点要要递归调用所有叶子节点的方法。
 5. 优点:
     1. 使客户端调用简单，客户端可以一致的使用组合结构或其中单个对象，用户就不必关心自己处理的是单个对象还是整个组合结构，这就简化了客户端代码。
     2. 更容易在组合体内加入对象部件. 客户端不必因为加入了新的对象部件而更改代码。这一点符合开闭原则的要求，对系统的二次开发和功能扩展很有利！
     3. 叶子对象可以被组合成更复杂的容器对象，而这个容器对象又可以被组合，这样不断递归下去，可以形成复杂的树形结构。
 6. 缺点:
     1. 使设计变得更加抽象，对象的业务规则如果很复杂，则实现组合模式具有很大挑战性，而且不是所有的方法都与叶子对象子类都有关联。
 */


protocol Shape {
    func add(shape: Shape)
    func removeShape(at: Int)
    func draw(fillColor: String)
}
/*:
 Leafs
 */
final class Square : Shape {
    func add(shape: Shape) {
        fatalError("叶子节点虽然实现，但不应该调用")
    }
    
    func removeShape(at: Int) {
        fatalError("叶子节点虽然实现，但不应该调用")
    }
    
    func draw(fillColor: String) {
        print("Drawing a Square with color \(fillColor)")
    }
}

final class Circle : Shape {
    func add(shape: Shape) {
        fatalError("叶子节点虽然实现，但不应该调用")
    }
    
    func removeShape(at: Int) {
        fatalError("叶子节点虽然实现，但不应该调用")
    }
    
    func draw(fillColor: String) {
        print("Drawing a circle with color \(fillColor)")
    }
}

/*:
 Composite
 */
final class Whiteboard : Shape {
    lazy var shapes = [Shape]()
    
    init(_ shapes:Shape...) {
        self.shapes = shapes
    }
    
    func add(shape: Shape) {
        shapes.append(shape)
    }
    
    func removeShape(at index: Int) {
        guard index < shapes.count else {
            return
        }
        shapes.remove(at: index)
    }
    
    func draw(fillColor: String) {
        for shape in self.shapes {
            shape.draw(fillColor: fillColor)
        }
    }
}
/*:
 ### Usage:
 */
var whiteboard = Whiteboard(Circle(), Square())
whiteboard.draw(fillColor: "Red")
