/*:
 ### **Mediator**
 ---
 
 [回到列表](Index)
 
 1. 定义:中介者模式(Mediator Pattern)：用一个中介对象（中介者）来封装一系列的对象交互，中介者使各对象不需要显式地相互引用，从而使其耦合松散，而且可以独立地改变它们之间的交互。中介者模式又称为调停者模式，它是一种对象行为型模式。如果在一个系统中对象之间的联系呈现为网状结构，可以考虑使用中介者模式。
    1. Mediator（抽象中介者）：它定义一个接口，该接口用于与各同事对象之间进行通信。
    2. ConcreteMediator（具体中介者）：它是抽象中介者的子类，通过协调各个同事对象来实现协作行为，它维持了对各个同事对象的引用。
    3. Colleague（抽象同事类）：它定义各个同事类公有的方法，并声明了一些抽象方法来供子类实现，同时它维持了一个对抽象中介者类的引用，其子类可以通过该引用来与中介者通信。
    4. ConcreteColleague（具体同事类）：它是抽象同事类的子类；每一个同事对象在需要和其他同事对象通信时，先与中介者通信，通过中介者来间接完成与其他同事类的通信；在具体同事类中实现了在抽象同事类中声明的抽象方法。

 2. 问题:系统中需要像所有的程序员发送消息，类似于广播。
 3. 解决方案:如果挨个告诉消息，需要跟所有的程序员交互。这时候引入一个消息中介，把消息发送给消息中介，中介把消息发送给所有的程序员。这样就不用与所有的程序员建立联系了。如果要给某个人发消息，只需要在发给中介者的时候带上对应的信息就好了。（下面例子中没有实现这种场景）
 4. 使用方法：
    1. 定义抽象同事协议（Receiver），定义交互的方法（receive(message:)）
    2. 定义抽象的中介者（Sender），及相关方法，同时它要保存所有的同事的实例
    3. 定义具体同事（Programmer），具体中介者（MessageMediator）
    5. 创建同事和中介者，并将同事传入中介者，然后可以像中介者发送消息。
 5. 优点:
    1. 中介者模式简化了对象之间的交互，它用中介者和同事的一对多交互代替了原来同事之间的多对多交互，一对多关系更容易理解、维护和扩展，将原本难以理解的网状结构转换成相对简单的星型结构。
    2. 中介者模式可将各同事对象解耦。中介者有利于各同事之间的松耦合，我们可以独立的改变和复用每一个同事和中介者，增加新的中介者和新的同事类都比较方便，更好地符合“开闭原则”。
    3. 可以减少子类生成，中介者将原本分布于多个对象间的行为集中在一起，改变这些行为只需生成新的中介者子类即可，这使各个同事类可被重用，无须对同事类进行扩展。
 6. 缺点:
    1. 在具体中介者类中包含了大量同事之间的交互细节，可能会导致具体中介者类非常复杂，使得系统难以维护。
 */


import Foundation

protocol Receiver {
    associatedtype MessageType
    func receive(message: MessageType)
}

protocol Sender {
    associatedtype MessageType
    associatedtype ReceiverType: Receiver
    
    var recipients: [ReceiverType] { get }
    
    func send(message: MessageType)
}

struct Programmer: Receiver {
    let name: String
    
    init(name: String) {
        self.name = name
    }
    
    func receive(message: String) {
        print("\(name) received: \(message)")
    }
}

final class MessageMediator: Sender {
    internal var recipients: [Programmer] = []
    
    func add(recipient: Programmer) {
        recipients.append(recipient)
    }
    
    func send(message: String) {
        for recipient in recipients {
            recipient.receive(message: message)
        }
    }
}

/*:
 ### Usage
 */
func spamMonster(message: String, worker: MessageMediator) {
    worker.send(message: message)
}

let messagesMediator = MessageMediator()

let user0 = Programmer(name: "Linus Torvalds")
let user1 = Programmer(name: "Avadis 'Avie' Tevanian")
messagesMediator.add(recipient: user0)
messagesMediator.add(recipient: user1)

spamMonster(message: "I'd Like to Add you to My Professional Network", worker: messagesMediator)
/*:
 >**Further Examples:** [Design Patterns in Swift](https://github.com/kingreza/Swift-Mediator)
 */

