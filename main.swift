import Foundation

print("Hello, World!")
//Part 1: Product Models (35 points)
//1.1
struct Product {
    let id: String
    let name: String
    let price: Double
    let category: Category
    let description: String
    
    enum Category {
        case electronics, clothing, food, books
    }
    
    var displayPrice: String {
        return String(format: "$%.2f", price)
    }
}
//1.2
struct CartItem {
    let product: Product
    var quantity: Int
    
    var subtotal: Double {
        return product.price * Double(quantity)
    }
    
    mutating func updateQuantity(_ newQuantity: Int) {
        if newQuantity > 0 {
            quantity = newQuantity
        }
    }
    
    mutating func increaseQuantity(by amount: Int) {
        if amount > 0 {
            quantity += amount
        }
    }
}

//Part 2: Shopping Cart Class (35 points)

class ShoppingCart {
    private(set) var items: [CartItem] = []
    var discountCode: String? = nil
    
    // Добавить товар
    func addItem(product: Product, quantity: Int = 1) {
        if let index = items.firstIndex(where: { $0.product.id == product.id }) {
            // если товар уже есть — обновляем количество
            var existing = items[index]
            existing.increaseQuantity(by: quantity)
            items[index] = existing
        } else {
            let newItem = CartItem(product: product, quantity: quantity)
            items.append(newItem)
        }
    }
    func removeItem(productId: String) {
           items.removeAll { $0.product.id == productId }
       }
       
       // Очистить корзину
       func clearCart() {
           items.removeAll()
           discountCode = nil
       }
       
       // Подсчёт итогов
       var subtotal: Double {
           return items.reduce(0) { $0 + $1.subtotal }
       }
       
       var discountAmount: Double {
           guard let code = discountCode else { return 0 }
           if code == "SAVE10" { return subtotal * 0.10 }
           else if code == "SAVE20" { return subtotal * 0.20 }
           else { return 0 }
       }
       
       var total: Double {
           return subtotal - discountAmount
       }
       
       var itemCount: Int {
           return items.reduce(0) { $0 + $1.quantity }
       }
       
       var isEmpty: Bool {
           return items.isEmpty
       }
   }
//Part 3: Order & Address (20 points)
//3.1
struct Address {
    let street: String
    let city: String
    let zipCode: String
    let country: String
    
    var formattedAddress: String {
        return "\(street), \(city), \(zipCode), \(country)"
    }
}
//3.2
struct Order {
    let orderId: String
    let items: [CartItem]
    let subtotal: Double
    let discountAmount: Double
    let total: Double
    let timestamp: Date
    let shippingAddress: Address
    
    init(from cart: ShoppingCart, shippingAddress: Address) {
        self.orderId = UUID().uuidString
        self.items = cart.items
        self.subtotal = cart.subtotal
        self.discountAmount = cart.discountAmount
        self.total = cart.total
        self.timestamp = Date()
        self.shippingAddress = shippingAddress
    }
    
    var itemCount: Int {
        return items.reduce(0) { $0 + $1.quantity }
    }
}

// Part 4: Testing & Demonstrations (10 points)
print("🛒 Shopping Cart System Demo")

let laptop = Product(id: "1", name: "MacBook Air", price: 1499.99, category: .electronics, description: "Apple laptop 13-inch")
let book = Product(id: "2", name: "Swift Basics", price: 39.99, category: .books, description: "Learn Swift quickly")
let tshirt = Product(id: "3", name: "Cool T-Shirt", price: 24.99, category: .clothing, description: "Comfort cotton")

let cart = ShoppingCart()
cart.addItem(product: laptop, quantity: 1)
cart.addItem(product: book, quantity: 2)
cart.addItem(product: tshirt, quantity: 3)

print("\n📦 Items in cart: \(cart.itemCount)")
print("Subtotal: \(cart.subtotal)")
print("Total (no discount): \(cart.total)")

// Применяем скидку
cart.discountCode = "SAVE10"
print("\n💰 Discount applied: \(cart.discountAmount)")
print("Total after discount: \(cart.total)")

// Удаляем товар
cart.removeItem(productId: "2")
print("\n🧹 After removing book:")
print("Items in cart: \(cart.itemCount)")
print("Subtotal: \(cart.subtotal)")

// Создаём адрес
let address = Address(street: "Abay 100", city: "Almaty", zipCode: "050000", country: "Kazakhstan")

// Создаём заказ
let order = Order(from: cart, shippingAddress: address)
print("\n📦 Order created:")
print("Order ID: \(order.orderId)")
print("Order total: \(order.total)")
print("Shipping address: \(order.shippingAddress.formattedAddress)")

// Очищаем корзину после оформления
cart.clearCart()
print("\n🧾 Cart after order:")
print("Is empty: \(cart.isEmpty)")
print("Order still has \(order.itemCount) items (snapshot saved)")



