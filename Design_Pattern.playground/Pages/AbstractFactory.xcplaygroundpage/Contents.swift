/*:
 ### **Abstract Factory**
 ---
 
 [回到列表](Index)
 
 
 1. 定义:抽象工厂模式是指当有多个抽象角色时，使用的一种工厂模式。抽象工厂模式可以向客户端提供一个接口，使客户端在不必指定产品的具体的情况下，创建多个产品族中的产品对象。
     **产品等级结构** ：产品等级结构即产品的继承结构，也可以叫做的产品的类型。比如抽象类是电视机，可以有海尔电视机、乐视电视机。
     **产品族** ：指由同一个工厂生产的，位于不同产品等级结构中的一组产品。
 2. 问题:假设我们产品有电视机和电冰箱，同事长虹和LG都生产者两种产品。
 3. 解决方案: 如果按照工厂方法来实现，需要创建电视机工厂，它能生产长虹电视机和LG电视机，电冰箱也是类似。显然这个再语义上不满足。所以这里可以使用抽象工厂模式。
 4. 使用方法：
     1. AbstractFactory（抽象工厂）：它声明了一组用于创建一族产品的方法，每一个方法对应一种产品。
     2. ConcreteFactory（具体工厂）：它实现了在抽象工厂中声明的创建产品的方法，生成一组具体产品，这些产品构成了一个产品族，每一个产品都位于某个产品等级结构中。
     3. AbstractProduct（抽象产品）：它为每种产品声明接口，在抽象产品中声明了产品所具有的业务方法。
     4. ConcreteProduct（具体产品）：它定义具体工厂生产的具体产品对象，实现抽象产品接口中声明的业务方法。
 5. 优点:
     1. 抽象工厂模式隔离了具体类的生成，使得客户并不需要知道什么被创建。由于这种隔离，更换一个具体工厂就变得相对容易。所有的具体工厂都实现了抽象工厂中定义的那些公共接口，因此只需改变具体工厂的实例，就可以在某种程度上改变整个软件系统的行为。另外，应用抽象工厂模式可以实现高内聚低耦合的设计目的，因此抽象工厂模式得到了广泛的应用。
     2. 当一个产品族中的多个对象被设计成一起工作时，它能够保证客户端始终只使用同一个产品族中的对象。这对一些需要根据当前环境来决定其行为的软件系统来说，是一种非常实用的设计模式。
     3. 增加新的具体工厂和产品族很方便，无须修改已有系统，符合“开闭原则”。

 6. 缺点:
     1. 在添加新的产品对象时，难以扩展抽象工厂来生产新种类的产品，这是因为在抽象工厂角色中规定了所有可能被创建的产品集合，要支持新种类的产品就意味着要对该接口进行扩展，而这将涉及到对抽象工厂角色及其所有子类的修改，显然会带来较大的不便。
     2. 开闭原则的倾斜性（增加新的工厂和产品族容易，增加新的产品等级结构麻烦）。
 */

import UIKit

//: Protocol

// 电视
protocol TV {
    func display()
}

// 冰箱
protocol Icebox {
    func use()
}

protocol Factory {
    func produceTV() -> TV
    func produceIcebox() -> Icebox
}

//: Product
class ChangHongTV: TV {
    func display() {
        print("ChangHongTV \(#function)")
    }
}

class LGTV: TV {
    func display() {
        print("LGTV \(#function)")
    }
}

class ChangHongIcebox: Icebox {
    func use() {
        print("ChangHongIcebox \(#function)")
    }
}

class LGIcebox: Icebox {
    func use() {
        print("LGIcebox \(#function)")
    }
}

//: Factory
class ChangHongFactory: Factory {
    func produceTV() -> TV {
        return ChangHongTV()
    }
    
    func produceIcebox() -> Icebox {
        return ChangHongIcebox()
    }
}

class LGFactory: Factory {
    func produceTV() -> TV {
        return LGTV()
    }
    
    func produceIcebox() -> Icebox {
        return LGIcebox()
    }
}

enum FactoryType {
    case changHong
    case LG
}

enum FactoryHelper {
    static func factory(for type: FactoryType) -> Factory {
        switch type {
        case .changHong:
            return ChangHongFactory()
        case .LG:
            return LGFactory()
        }
    }
}

//: ### Usage
let changHongFactory = FactoryHelper.factory(for: .changHong)
let tv = changHongFactory.produceTV()
tv.display()
let icebox = changHongFactory.produceIcebox()
icebox.use()

let lgFactory = FactoryHelper.factory(for: .LG)






