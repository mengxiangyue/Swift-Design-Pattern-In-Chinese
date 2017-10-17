/*:
 ### **Simple Factory**
 ---
 
 [回到列表](Index)

 1. 定义:简单工厂模式（Simple Factory Pattern）属于类的创新型模式，又叫静态工厂方法模式（Static FactoryMethod Pattern）,是通过专门定义一个类来负责创建其他类的实例，被创建的实例通常都具有共同的父类。**简单工厂模式并不是 GoF 23种设计模式中的一种**。
 2. 问题:假设我们的APP支持多国货币，需要根据国家返回对应的货币符号及编码。
 3. 解决方案:首先我们可以先定义我们支持的国家。我们先写了一版代码 *CurrencyFactoryOld*，能够满足我们的需求。但是这样的问题是，所有的逻辑都放在一个方法中，如果逻辑比较多，会造成这个方法阅读起来十分困难。另外每次添加一中货币都需要修改这个方法，违反了对扩展开放的原则（简单工厂方法也会违背该原则，只是会更加容易扩展）。
 4. 使用方法：
     1. 定义每个类都需要遵循的协议（其他语言有的是定义共同的父类，一般是为了提供共有方法的实现，这个可以通过 swift protocol extension）。
     2. 定义每个具体功能的类型，遵守前面定义的协议。
     3. 定义工厂类，提供创建方法，根据传入的参数返回对应的实例。
 5. 优点:
     1. 工厂类含有必要的判断逻辑，可以决定在什么时候创建哪一个产品类的实例，客户端可以免除直接创建产品对象的责任，而仅仅“消费”产品；简单工厂模式通过这种做法实现了对责任的分割，它提供了专门的工厂类用于创建对象。
     2. 客户端无须知道所创建的具体产品类的类名，只需要知道具体产品类所对应的参数即可，对于一些复杂的类名，通过简单工厂模式可以减少使用者的记忆量。
     3. 通过引入配置文件，可以在不修改任何客户端代码的情况下更换和增加新的具体产品类，在一定程度上提高了系统的灵活性。
 6. 缺点:
     1. 由于工厂类集中了所有产品创建逻辑，一旦不能正常工作，整个系统都要受到影响。
     2. 使用简单工厂模式将会增加系统中类的个数，在一定程序上增加了系统的复杂度和理解难度。
     3. 系统扩展困难，一旦添加新产品就不得不修改工厂逻辑，在产品类型较多时，有可能造成工厂逻辑过于复杂，不利于系统的扩展和维护。
     4. 简单工厂模式由于使用了静态工厂方法，造成工厂角色无法形成基于继承的等级结构。
 */

import UIKit

enum Country {
    case unitedStates, spain, uk, greece
}

enum CurrencyFactoryOld {
    static func currency(for country: Country) -> (String, String)? {
        switch country {
        case .spain, .greece :
            return ("€", "EUR")
        case .unitedStates :
            return ("$", "EUR")
        default:
            return nil
        }
    }
}

//: ### 使用
if let (symbol, code) = CurrencyFactoryOld.currency(for: .unitedStates) {
    print("\(symbol) \(code)")
}

protocol Currency {
    /// 货币符号
    func symbol() -> String
    /// 货币编码
    func code() -> String
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


/* 这里使用的是枚举类，也可以使用 struct、class。其实直接一个全局的方法也是可以的，但是全局方法调用的时候不好体现出来 XXXFactory.createXX() 这样的语义，所以还是包装在类型中。
 */
enum CurrencyFactory {
    static func currency(for country:Country) -> Currency? {
        switch country {
        case .spain, .greece :
            return Euro()
        case .unitedStates :
            return UnitedStatesDolar()
        default:
            return nil
        }
        
    }
}
/*:
 ### 使用
 */
let noCurrencyCode = "No Currency Code Available"

CurrencyFactory.currency(for: .greece)?.code() ?? noCurrencyCode
CurrencyFactory.currency(for: .spain)?.code() ?? noCurrencyCode
CurrencyFactory.currency(for: .unitedStates)?.code() ?? noCurrencyCode
CurrencyFactory.currency(for: .uk)?.code() ?? noCurrencyCode



