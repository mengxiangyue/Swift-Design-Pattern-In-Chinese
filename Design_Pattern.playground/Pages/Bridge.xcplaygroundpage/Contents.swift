/*:
 ### **Bridge**
 ---
 
 [回到列表](Index)
 
 1. 定义:桥接模式(Bridge Pattern)：将抽象部分与它的实现部分分离，使它们都可以独立地变化。在使用桥接模式时，我们首先应该识别出一个类所具有的两个独立变化的维度，将它们设计为两个独立的继承等级结构，为两个维度都提供抽象层，并建立抽象耦合。
 2. 问题:家用电器和遥控器都有很多种，现在假设任何一种遥控器都能控制所有的电器。
 3. 解决方案:从家用电器和遥控器两个维度构造类的关系，然后使遥控器关联某种电器，实现操作电器的目的。（按照继承实现可能会多产生TVSwitch类，VacuumCleanerSwitch类，如果再添加一种遥控器呢，对应的又得增加两个具体遥控器类，但是桥接模式就只增加新的遥控器类就可以了）
 4. 使用方法：
     1. 定义两个维度的协议，其中一个主操作协议（Abstraction（抽象类）），一个被关联协议（Implementor（实现类接口））。
     2. 分别根据实际情况创建对应的子类
 5. 优点:
     1.分离抽象接口及其实现部分。桥接模式使用“对象间的关联关系”解耦了抽象和实现之间固有的绑定关系，使得抽象和实现可以沿着各自的维度来变化。所谓抽象和实现沿着各自维度的变化，也就是说抽象和实现不再在同一个继承层次结构中，而是“子类化”它们，使它们各自都具有自己的子类，以便任何组合子类，从而获得多维度组合对象。
     2. 在很多情况下，桥接模式可以取代多层继承方案，多层继承方案违背了“单一职责原则”，复用性较差，且类的个数非常多，桥接模式是比多层继承方案更好的解决方法，它极大减少了子类的个数。
     3。 桥接模式提高了系统的可扩展性，在两个变化维度中任意扩展一个维度，都不需要修改原有系统，符合“开闭原则”。
 6. 缺点:
     1. 桥接模式的使用会增加系统的理解与设计难度，由于关联关系建立在抽象层，要求开发者一开始就针对抽象层进行设计与编程。
     2。 桥接模式要求正确识别出系统中两个独立变化的维度，因此其使用范围具有一定的局限性，如何正确识别两个独立维度也需要一定的经验积累。
 */


import Foundation

// 遥控器
protocol Switch {
    var appliance: Appliance {get set}
    func turnOn()
}

// 电器
protocol Appliance {
    func run()
}

class RemoteControl: Switch {
    var appliance: Appliance
    
    func turnOn() {
        self.appliance.run()
    }
    
    init(appliance: Appliance) {
        self.appliance = appliance
    }
}

class TV: Appliance {
    func run() {
        print("tv turned on");
    }
}

class VacuumCleaner: Appliance {
    func run() {
        print("vacuum cleaner turned on")
    }
}
/*:
 ### Usage
 */
var tvRemoteControl = RemoteControl(appliance: TV())
tvRemoteControl.turnOn()

var fancyVacuumCleanerRemoteControl = RemoteControl(appliance: VacuumCleaner())
fancyVacuumCleanerRemoteControl.turnOn()

