/*:
 ### **Singleton**
 ---
 
 [回到列表](Index)
 
 1. 定义:代理模式：给某一个对象提供一个代理或占位符，并由代理对象来控制对原对象的访问。代理模式是一种对象结构型模式。在代理模式中引入了一个新的代理对象，代理对象在客户端对象和目标对象之间起到中介的作用，它去掉客户不能看到的内容和服务或者增添客户需要的额外的新服务。
 2. 分类：
     1. 远程代理(Remote Proxy)：为一个位于不同的地址空间的对象提供一个本地的代理对象，这个不同的地址空间可以是在同一台主机中，也可是在另一台主机中，远程代理又称为大使(Ambassador)。
     2. 虚拟代理(Virtual Proxy)：如果需要创建一个资源消耗较大的对象，先创建一个消耗相对较小的对象来表示，真实对象只在需要时才会被真正创建。
     3. 保护代理(Protect Proxy)：控制对一个对象的访问，可以给不同的用户提供不同级别的使用权限。
     4. 缓冲代理(Cache Proxy)：为某一个目标操作的结果提供临时的存储空间，以便多个客户端可以共享这些结果。
     5. 智能引用代理(Smart Reference Proxy)：当一个对象被引用时，提供一些额外的操作，例如将对象被调用的次数记录下来等。
 3. 问题:HAL9000能够打开任意的门，但是我们希望只有在校验密码正确的情况下才能让HAL9000开门。同时我们又不能修改HAL9000的代码。
 4. 解决方案:为HAL9000添加一个代理类，代理类中校验密码正确与否，校验通过再去调用HAL9000开门。下面HAL9000例子是保护代理。最后还提供一个虚拟代理。
 5. 使用方法：
     1. 定义抽象主题角色Subject（DoorOperator），声明其中的方法及属性。
     2. 定义真实主题角色 RealSubject （HAL9000），它遵守抽象主题角色Subject。
     3. 定义代理主题角色 Proxy （CurrentComputer），它包含了对真实主题角色 RealSubject 的引用，并且添加对应的处理逻辑。
 6. 优点:
     1. 能够协调调用者和被调用者，在一定程度上降低了系统的耦合度。
     2. 客户端可以针对抽象主题角色进行编程，增加和更换代理类无须修改源代码，符合开闭原则，系统具有较好的灵活性和可扩展性。
     3. 其他
         1. 远程代理为位于两个不同地址空间对象的访问提供了一种实现机制，可以将一些消耗资源较多的对象和操作移至性能更好的计算机上，提高系统的整体运行效率。
         2. 虚拟代理通过一个消耗资源较少的对象来代表一个消耗资源较多的对象，可以在一定程度上节省系统的运行开销。
         3. 缓冲代理为某一个操作的结果提供临时的缓存存储空间，以便在后续使用中能够共享这些结果，优化系统性能，缩短执行时间。
         4. 保护代理可以控制对一个对象的访问权限，为不同用户提供不同级别的使用权限。
 7. 缺点:
     1. 由于在客户端和真实主题之间增加了代理对象，因此有些类型的代理模式可能会造成请求的处理速度变慢，例如保护代理。
     2. 实现代理模式需要额外的工作，而且有些代理模式的实现过程较为复杂，例如远程代理。
 */


import Foundation

/*:
 保护代理 Protection Proxy
 */
protocol DoorOperator {
    func open(doors: String) -> String
}

class HAL9000 : DoorOperator {
    func open(doors: String) -> String {
        return ("HAL9000: Affirmative, Dave. I read you. Opened \(doors).")
    }
}

class CurrentComputer : DoorOperator {
    private var computer: HAL9000!
    
    func authenticate(password: String) -> Bool {
        
        guard password == "pass" else {
            return false;
        }
        
        computer = HAL9000()
        
        return true
    }
    
    func open(doors: String) -> String {
        
        guard computer != nil else {
            return "Access Denied. I'm afraid I can't do that."
        }
        
        return computer.open(doors: doors)
    }
}
/*:
 ### Usage
 */
let computer = CurrentComputer()
let podBay = "Pod Bay Doors"

computer.open(doors: podBay)

computer.authenticate(password: "pass")
computer.open(doors: podBay)


/*:
 虚拟代理 Virtual Proxy
 */
protocol HEVSuitMedicalAid {
    func administerMorphine() -> String
}

class HEVSuit : HEVSuitMedicalAid {
    func administerMorphine() -> String {
        return "Morphine administered."
    }
}

class HEVSuitHumanInterface : HEVSuitMedicalAid {
    lazy private var physicalSuit: HEVSuit = HEVSuit()
    
    func administerMorphine() -> String {
        return physicalSuit.administerMorphine()
    }
}
/*:
 ### Usage
 */
let humanInterface = HEVSuitHumanInterface()
humanInterface.administerMorphine()

