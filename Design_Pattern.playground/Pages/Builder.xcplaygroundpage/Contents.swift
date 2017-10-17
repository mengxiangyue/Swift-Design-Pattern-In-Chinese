/*:
 ### **Builder**
 ---
 
 [回到列表](Index)
 
 1. 定义:建造者模式，将一个复杂对象的构建与它的表示分离，使得同样的构建过程创建不同的表示。
 2. 问题:建造一个死亡之星，它由x，y，z三个变量确定显示的位置，三个变量缺少任何一个都不能正确的建造。
 3. 解决方案:使用建造者模式建造。
 4. 使用方法：
     1. 经典建造模式实现（最下面给出一个简单实现）
         1. 定义产品，即最终建造的结果
         2. 定义抽奖的建造者 Builder,定义其中需要x、y、z变量
         3. 定义具体的建造者
         4. 定义指挥者 Director，将 builder 传入 Director 将会获得对应的产品
     2. Swift 修改实现。 具体的builder中，大部分都是直接保存一些数据，或者保存处理后的数据，如果是直接保存数据，其实没有必要抽象builder这一层了。另外Director只是接收builder，然后获取最终产品，可以直接将builder 传入到最终产品，获取结果更简单。
         1. 定义对应的产品类
         2. 定义抽象 Builder （直接保存一些数据，不需要这一层）
         3. 定义距离的 Builder 类
         4. 将builder 传入对应的产品，获取具体产品
 5. 优点:
     1. 在建造者模式中， 客户端不必知道产品内部组成的细节，将产品本身与产品的创建过程解耦，使得相同的创建过程可以创建不同的产品对象。
     2. 每一个具体建造者都相对独立，而与其他的具体建造者无关，因此可以很方便地替换具体建造者或增加新的具体建造者， 用户使用不同的具体建造者即可得到不同的产品对象 。
     3. 可以更加精细地控制产品的创建过程 。将复杂产品的创建步骤分解在不同的方法中，使得创建过程更加清晰，也更方便使用程序来控制创建过程。
     4. 增加新的具体建造者无须修改原有类库的代码，指挥者类针对抽象建造者类编程，系统扩展方便，符合“开闭原则”
 6. 缺点:
     1. 建造者模式所创建的产品一般具有较多的共同点，其组成部分相似，如果产品之间的差异性很大，则不适合使用建造者模式，因此其使用范围受到一定的限制。
     2. 如果产品的内部变化复杂，可能会导致需要定义很多具体建造者类来实现这种变化，导致系统变得很庞大。
 */


import Foundation

protocol Builder {
    var x: Double? { get set }
    var y: Double? { get set }
    var z: Double? { get set }
    
    
    init(buildClosure: (Self) -> ())
}


final class DeathStarBuilder: Builder {
    
    var x: Double?
    var y: Double?
    var z: Double?
    
    required init(buildClosure: (DeathStarBuilder) -> ()) {
        buildClosure(self)
        // 如果需要后续处理数据 可以在这里处理
    }
}

struct DeathStar : CustomStringConvertible {
    
    let x: Double
    let y: Double
    let z: Double
    
    init?(builder: DeathStarBuilder) {
        
        if let x = builder.x, let y = builder.y, let z = builder.z {
            self.x = x
            self.y = y
            self.z = z
        } else {
            return nil
        }
    }
    
    var description:String {
        return "Death Star at (x:\(x) y:\(y) z:\(z))"
    }
}
/*:
 ### Usage
 */
let empire = DeathStarBuilder { builder in
    builder.x = 0.1
    builder.y = 0.2
    builder.z = 0.3
}

let deathStar = DeathStar(builder:empire)
print(deathStar)


/*:
 ### 经典模式
 */

class Product {
    private var parts: [String] = []
    func  add(part: String) {
        parts.append(part)
    }
    func show() {
        for part in parts {
            print("\(part)")
        }
    }
}

protocol Builder_ {
    func buildPartA()
    func buildPartB()
    func getProduct() -> Product
}

class ConcreteBuilder: Builder_ {
    private var product = Product()
    func buildPartA() {
        product.add(part: "Part A")
    }
    func buildPartB() {
        product.add(part: "Part B")
    }
    func getProduct() -> Product {
        return product
    }
}

class Director {
    init(builder: Builder_) {
        builder.buildPartA()
        builder.buildPartB()
    }
}

//: ### 使用

let builder = ConcreteBuilder()
let director = Director(builder: builder)
let product = builder.getProduct()
product.show()

