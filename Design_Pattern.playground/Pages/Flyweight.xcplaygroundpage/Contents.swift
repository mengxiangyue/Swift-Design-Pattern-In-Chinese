/*:
 ### **Flyweight**
 ---
 
 [回到列表](Index)
 
 1. 定义:享元模式(Flyweight Pattern)：运用共享技术有效地支持大量细粒度对象的复用。系统只使用少量的对象，而这些对象都很相似，状态变化很小，可以实现对象的多次复用。由于享元模式要求能够共享的对象必须是细粒度对象，因此它又称为轻量级模式，它是一种对象结构型模式。享元对象能做到共享的关键是区分了内部状态(Intrinsic State)和外部状态(Extrinsic State)。内部状态是存储在享元对象内部并且不会随环境改变而改变的状态，内部状态可以共享。外部状态是随环境改变而改变的、不可以共享的状态。
 2. 问题:咖啡店出售不同的咖啡，但是咖啡都是基于基础的咖啡然后添加不同的调味品制作，如果每种咖啡都创建对象，将会造成资源浪费。
 3. 解决方案:使用享元模式，将咖啡调味品当做享元对象处理，共享这些调味品，将会节省很大的内存。
 4. 使用方法：
     1. 定义一个抽象享元协议，定义享元里的状态和方法（例子中省略了）。
     2. 创建具体的享元类，实现抽象享元协议。（SpecialityCoffee）
     3. 创建享元工厂，用于创建和缓存享元实例。（Menu）
     4. 客户端通过享元工厂获取享元对象。（CoffeeShop）
 5. 优点:
     1. 可以极大减少内存中对象的数量，使得相同或相似对象在内存中只保存一份，从而可以节约系统资源，提高系统性能。
     2. 享元模式的外部状态相对独立，而且不会影响其内部状态，从而使得享元对象可以在不同的环境中被共享。
 6. 缺点:
     1. 享元模式使得系统变得复杂，需要分离出内部状态和外部状态，这使得程序的逻辑复杂化。
     2. 为了使对象可以共享，享元模式需要将享元对象的部分状态外部化，而读取外部状态将使得运行时间变长。
 */

import Foundation

// 咖啡调味品将会是享元
final class SpecialityCoffee: CustomStringConvertible {
    var origin: String
    var description: String {
        get {
            return origin
        }
    }
    
    init(origin: String) {
        self.origin = origin
    }
}

// 菜单扮演工厂和换攒咖啡调味品享元对象的角色
final class Menu {
    private var coffeeAvailable: [String: SpecialityCoffee] = [:]
    
    func lookup(origin: String) -> SpecialityCoffee? {
        if coffeeAvailable.index(forKey: origin) == nil {
            coffeeAvailable[origin] = SpecialityCoffee(origin: origin)
        }
        
        return coffeeAvailable[origin]
    }
}

final class CoffeeShop {
    private var orders: [Int: SpecialityCoffee] = [:]
    private var menu = Menu()
    
    func takeOrder(origin: String, table: Int) {
        orders[table] = menu.lookup(origin: origin)
    }
    
    func serve() {
        for (table, origin) in orders {
            print("Serving \(origin) to table \(table)")
        }
    }
}
/*:
 ### Usage
 */
let coffeeShop = CoffeeShop()

coffeeShop.takeOrder(origin: "Yirgacheffe, Ethiopia", table: 1)
coffeeShop.takeOrder(origin: "Buziraguhindwa, Burundi", table: 3)

coffeeShop.serve()
