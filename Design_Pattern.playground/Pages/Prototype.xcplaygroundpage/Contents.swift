/*:
 ### **Prototype Pattern**
 ---
 
 [回到列表](Index)
 
 1. 定义:原型模式(Prototype  Pattern)：使用原型实例指定创建对象的种类，并且通过拷贝这些原型创建新的对象。原型模式是一种对象创建型模式。。
 2. 问题:例如下面例子中需要创建戈登计划乐队的三名成员。（真的不理解外国人下面这个破例子，有点强行解释的意思）
 3. 解决方案:定义一个原型，然后通过 clone，创建一个新的实例，修改对应的属性。
 4. 使用方法：
     1. 定义一个原型类，提供 clone 方法。
     2. 创建原型类，调用 clone 方法，获取新的实例，然后根据需要修改对应的属性。
 5. 优点:
 (1) 当创建新的对象实例较为复杂时，使用原型模式可以简化对象的创建过程，通过复制一个已有实例可以提高新实例的创建效率。
 (2) 扩展性较好，由于在原型模式中提供了抽象原型类，在客户端可以针对抽象原型类进行编程，而将具体原型类写在配置文件中，增加或减少产品类对原有系统都没有任何影响。
 (3) 原型模式提供了简化的创建结构，工厂方法模式常常需要有一个与产品类等级结构相同的工厂等级结构，而原型模式就不需要这样，原型模式中产品的复制是通过封装在原型类中的克隆方法实现的，无须专门的工厂类来创建产品。
 (4) 可以使用深克隆的方式保存对象的状态，使用原型模式将对象复制一份并将其状态保存起来，以便在需要的时候使用（如恢复到某一历史状态），可辅助实现撤销操作。
 6. 缺点:
 (1) 需要为每一个类配备一个克隆方法，而且该克隆方法位于一个类的内部，当对已有的类进行改造时，需要修改源代码，违背了“开闭原则”。
 (2) 在实现深克隆时需要编写较为复杂的代码，而且当对象之间存在多重的嵌套引用时，为了实现深克隆，每一层对象对应的类都必须支持深克隆，实现起来可能会比较麻烦。
 */


import Foundation

class ChungasRevengeDisplay {
    var name: String?
    let font: String
    
    init(font: String) {
        self.font = font
    }
    
    func clone() -> ChungasRevengeDisplay {
        return ChungasRevengeDisplay(font:self.font)
    }
}
/*:
 ### Usage
 */
// Gotan Project 乐队的三位成员，分别是Philippe Cohen Sola、Christophe Mueller以及 Eduardo Makaroff
let Prototype = ChungasRevengeDisplay(font:"GotanProject")

let Philippe = Prototype.clone()
Philippe.name = "Philippe"

let Christoph = Prototype.clone()
Christoph.name = "Christoph"

let Eduardo = Prototype.clone()
Eduardo.name = "Eduardo"

