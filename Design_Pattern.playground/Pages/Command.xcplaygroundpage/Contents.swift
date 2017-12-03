/*:
 ### **Command**
 ---
 
 [回到列表](Index)
 
 1. 定义:命令模式(Command Pattern)：将一个请求封装为一个对象，从而让我们可用不同的请求对客户进行参数化；对请求排队或者记录请求日志，以及支持可撤销的操作。命令模式是一种对象行为型模式，其别名为动作(Action)模式或事务(Transaction)模式。
 2. 问题:有一个门，我们能够使用命令操作它。假设现在有开门、关门的命令。另外有多个操作者都会操作这个门（例子中就一个）。
 3. 解决方案:由于门的命令和操作者可能是多对多的关系，所以如果为没一个操作者都创建对应的处理方法，会很麻烦。可以将命令和操作者进行独立解耦，然后将命令关联到操作者中实现解耦，这就是命令模式。
 4. 使用方法：
    1. 定义抽象命令 Command（协议），其中声明了具体命令执行的方法。
    2. 定义对应的具体的命令类，遵守Command协议。
    3. 定义调用者（例子中HAL9000DoorsOperations），调用者关联命令类，并且调用命令类中具体方法，执行具体的操作。关联的命令类，在程序运行时可以传入。
    4. 客户端创建调用者，并且设置需要的命令类，然后调用需要使用的方法。
 5. 优点:
    1. 降低系统的耦合度。由于请求者与接收者之间不存在直接引用，因此请求者与接收者之间实现完全解耦，相同的请求者可以对应不同的接收者，同样，相同的接收者也可以供不同的请求者使用，两者之间具有良好的独立性。
    2. 新的命令可以很容易地加入到系统中。由于增加新的具体命令类不会影响到其他类，因此增加新的具体命令类很容易，无须修改原有系统源代码，甚至客户类代码，满足“开闭原则”的要求。
 6. 缺点:
    1. 使用命令模式可能会导致某些系统有过多的具体命令类。因为针对每一个对请求接收者的调用操作都需要设计一个具体命令类，因此在某些系统中可能需要提供大量的具体命令类，这将影响命令模式的使用。
 */


import Foundation

protocol DoorCommand {
    func execute() -> String
}

class OpenCommand : DoorCommand {
    let doors:String
    
    required init(doors: String) {
        self.doors = doors
    }
    
    func execute() -> String {
        return "Opened \(doors)"
    }
}

class CloseCommand : DoorCommand {
    let doors:String
    
    required init(doors: String) {
        self.doors = doors
    }
    
    func execute() -> String {
        return "Closed \(doors)"
    }
}

class HAL9000DoorsOperations {
    let openCommand: DoorCommand
    let closeCommand: DoorCommand
    
    init(doors: String) {
        self.openCommand = OpenCommand(doors:doors)
        self.closeCommand = CloseCommand(doors:doors)
    }
    
    func close() -> String {
        return closeCommand.execute()
    }
    
    func open() -> String {
        return openCommand.execute()
    }
}
/*:
 ### Usage:
 */
let podBayDoors = "Pod Bay Doors"
let doorModule = HAL9000DoorsOperations(doors:podBayDoors)

doorModule.open()
doorModule.close()

