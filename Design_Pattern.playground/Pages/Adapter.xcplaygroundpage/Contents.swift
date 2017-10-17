/*:
 ### **Adapter**
 ---
 
 [回到列表](Index)
 
 > 只讨论对象适配器，并未讨论类适配器。
 
 1. 定义:适配器模式(Adapter Pattern)：将一个接口转换成客户希望的另一个接口，使接口不兼容的那些类可以一起工作，其别名为包装器(Wrapper)。适配器模式既可以作为类结构型模式，也可以作为对象结构型模式。
 2. 问题:在星战中，有一个死星激光炮。由于进入发展，新建造了一个，但是原来的瞄准标准已经不适用新的，但是新的中有与之对应的。
 3. 解决方案:定义一个适配器类，使旧的的瞄准方案，能够使用新的激光炮。
 4. 使用方法：
     1. 定义 Target（目标抽象类）：目标抽象类定义客户所需接口，可以是一个抽象类或接口，也可以是具体类。最终需要适配的类或接口（这里指旧的瞄准标准）
     2. 定义 Adaptee (适配者类)：需要被适配的类（这里指新的的激光炮）。
     3. 定义 Adapter（适配器类）：适配器作为一个转换器，对Adaptee和Target进行适配，适配器类是适配器模式的核心，在对象适配器中，它通过继承Target并关联一个Adaptee对象使二者产生联系。
 5. 优点:
     1. 将目标类和适配者类解耦，通过引入一个适配器类来重用现有的适配者类，无须修改原有结构。
     2. 增加了类的透明性和复用性，将具体的业务实现过程封装在适配者类中，对于客户端类而言是透明的，而且提高了适配者的复用性，同一个适配者类可以在多个不同的系统中复用。
     3. 灵活性和扩展性都非常好，通过使用配置文件，可以很方便地更换适配器，也可以在不修改原有代码的基础上增加新的适配器类，完全符合“开闭原则”
     4. 一个对象适配器可以把多个不同的适配者类适配到同一个目标，也就是说，同一个适配器可以把适配者类和它的子类都适配到目标接口。
 6. 缺点:
     1. 对于对象适配器来说，更换适配器的实现过程比较复杂。
 */


import Foundation

// 以前的死星激光炮瞄准标准
protocol OlderDeathStarSuperLaserAiming {
    var angleV: NSNumber {get}
    var angleH: NSNumber {get}
}
/*:
 **Adaptee**
 */
struct DeathStarSuperlaserTarget {
    let angleHorizontal: Double
    let angleVertical: Double
    
    init(angleHorizontal:Double, angleVertical:Double) {
        self.angleHorizontal = angleHorizontal
        self.angleVertical = angleVertical
    }
}
/*:
 **Adapter**
 */
struct OldDeathStarSuperlaserTarget : OlderDeathStarSuperLaserAiming {
    private let target : DeathStarSuperlaserTarget
    
    var angleV:NSNumber {
        return NSNumber(value: target.angleVertical)
    }
    
    var angleH:NSNumber {
        return NSNumber(value: target.angleHorizontal)
    }
    
    init(_ target:DeathStarSuperlaserTarget) {
        self.target = target
    }
}
/*:
 ### Usage
 */
let target = DeathStarSuperlaserTarget(angleHorizontal: 14.0, angleVertical: 12.0)
let oldFormat = OldDeathStarSuperlaserTarget(target)


/*:
 ### 类适配器 例子
 */

/* DeathStarSuperlaserTarget 如果是类 就可以按照下面的样子写了
struct OldDeathStarSuperlaserTarget1: DeathStarSuperlaserTarget, OlderDeathStarSuperLaserAiming {
    var angleV:NSNumber {
        return NSNumber(value: angleVertical)
    }
    
    var angleH:NSNumber {
        return NSNumber(value: angleHorizontal)
    }
}
 */
