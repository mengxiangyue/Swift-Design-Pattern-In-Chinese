/*:
 ### **Simple Factory**
 ---
 
 [回到列表](Index)
 
 > 本节是在简单工厂模式上演进过来的，所以下面的好多东西与简单工厂相同。
 
 1. 定义:工厂方法模式（Factory Method Pattern）是一种常用的对象创建型设计模式,此模式的核心精神是封装类中不变的部分，提取其中个性化善变的部分为独立类，通过依赖注入以达到解耦、复用和方便后期维护拓展的目的。它的核心结构有四个角色，分别是抽象工厂；具体工厂；抽象产品；具体产品。
 2. 问题:假设我们的APP支持多国货币，需要根据国家返回对应的货币符号及编码。
 3. 解决方案: 为每种货币定义对应的产品及工厂。
 4. 使用方法：
     1. 定义抽象的产品 Currency， 定义抽象的工厂 CurrencyFactory。
     2. 根据产品类型实现具体的产品，及每个产品对应的工厂。
     3. 根据需求使用每个具体的工厂。
 5. 优点:
     1. 在工厂方法模式中，工厂方法用来创建客户所需要的产品，同时还向客户隐藏了哪种具体产品类将被实例化这一细节，用户只需要关心所需产品对应的工厂，无须关心创建细节，甚至无须知道具体产品类的类名。
     2. 基于工厂角色和产品角色的多态性设计是工厂方法模式的关键。它能够使工厂可以自主确定创建何种产品对象，而如何创建这个对象的细节则完全封装在具体工厂内部。工厂方法模式之所以又被称为多态工厂模式，是因为所有的具体工厂类都具有同一抽象父类。
     3. 使用工厂方法模式的另一个优点是在系统中加入新产品时，无须修改抽象工厂和抽象产品提供的接口，无须修改客户端，也无须修改其他的具体工厂和具体产品，而只要添加一个具体工厂和具体产品就可以了。这样，系统的可扩展性也就变得非常好，完全符合“开闭原则”。
 6. 缺点:
     1. 在添加新产品时，需要编写新的具体产品类，而且还要提供与之对应的具体工厂类，系统中类的个数将成对增加，在一定程度上增加了系统的复杂度，有更多的类需要编译和运行，会给系统带来一些额外的开销。
     2. 由于考虑到系统的可扩展性，需要引入抽象层，在客户端代码中均使用抽象层进行定义，增加了系统的抽象性和理解难度，且在实现时可能需要用到DOM、反射等技术，增加了系统的实现难度。
 7. 对比简单工厂
     1. 在GoF的23中设计模式中，简单工厂模式只是作为工厂方法模式的一种特例。
     2. 工厂方法模式的调用者需要知道具体要使用的工厂才能得到最后的产品，简单工厂只需要知道想得到的产品就能够得到最终的产品。
     3. 简单工厂模式每添加一种产品都需要修改工厂类，违反开闭原则。工厂方法不需要修改工厂类，但是需要添加新的工厂。
 
 优缺点参考文章:[http://design-patterns.readthedocs.io/zh_CN/latest/creational_patterns/factory_method.html](http://design-patterns.readthedocs.io/zh_CN/latest/creational_patterns/factory_method.html)
 */

import UIKit

protocol Currency {
    /// 货币符号
    func symbol() -> String
    /// 货币编码
    func code() -> String
}

protocol CurrencyFactory {
    func createCurrency() -> Currency
}

class Euro : Currency {
    func symbol() -> String {
        return "€"
    }
    
    func code() -> String {
        return "EUR"
    }
}

class UnitedStatesDolar : Currency {
    func symbol() -> String {
        return "$"
    }
    
    func code() -> String {
        return "USD"
    }
}

class EuroFactory: CurrencyFactory {
    func createCurrency() -> Currency {
        return Euro()
    }
}

class UnitedStatesDolarFactory: CurrencyFactory {
    func createCurrency() -> Currency {
        return UnitedStatesDolar()
    }
}

//: ### 使用
print(EuroFactory().createCurrency().symbol())




