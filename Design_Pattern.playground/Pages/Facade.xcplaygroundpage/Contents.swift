/*:
 ### **Facade**
 ---
 
 [回到列表](Index)
 
 1. 定义:外观模式：为子系统中的一组接口提供一个统一的入口。外观模式定义了一个高层接口，这个接口使得这一子系统更加容易使用。
 2. 问题:外观模式没有一个明确的模式，只要将原来子系统进行一个封装提供一个统一的对外接口，基本上都可以算是外观模式。例如经常使用的UserDefaults，可能感觉不太好用可以提供一个好用的API。
 3. 解决方案:省略。
 4. 使用方法：省略。
 5. 优点:
     1. 它对客户端屏蔽了子系统组件，减少了客户端所需处理的对象数目，并使得子系统使用起来更加容易。通过引入外观模式，客户端代码将变得很简单，与之关联的对象也很少。
     2. 它实现了子系统与客户端之间的松耦合关系，这使得子系统的变化不会影响到调用它的客户端，只需要调整外观类即可。
     3。 一个子系统的修改对其他子系统没有任何影响，而且子系统内部变化也不会影响到外观对象。
 6. 缺点:
     1. 不能很好地限制客户端直接使用子系统类，如果对客户端访问子系统类做太多的限制则减少了可变性和灵活性。
     2. 如果设计不当，增加新的子系统可能需要修改外观类的源代码，违背了开闭原则。
 */


import Foundation

enum Eternal {
    
    static func set(_ object: Any, forKey defaultName: String) {
        let defaults: UserDefaults = UserDefaults.standard
        defaults.set(object, forKey:defaultName)
        defaults.synchronize()
    }
    
    static func object(forKey key: String) -> AnyObject! {
        let defaults: UserDefaults = UserDefaults.standard
        return defaults.object(forKey: key) as AnyObject!
    }
    
}
/*:
 ### Usage
 */
Eternal.set("Disconnect me. I’d rather be nothing", forKey:"Bishop")
Eternal.object(forKey: "Bishop")

