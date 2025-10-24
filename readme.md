Shopping Cart System

This project demonstrates the difference between **structs** and **classes** in Swift using a simple shopping cart system.
It shows how structs are used for independent value data, while classes are used for shared, mutable state.

Project Description

The project includes the following components:

* **Product** — a struct describing a product (name, price, category, description).
* **CartItem** — a struct that connects a product with its quantity.
* **ShoppingCart** — a class representing the shopping cart; it stores items, calculates totals, and applies discounts.
* **Address** — a struct that holds shipping address information.
* **Order** — a struct that represents a snapshot of the cart at the moment of checkout.

Main Functionality

* Add and remove products from the cart.
* Calculate subtotal, total, and item count.
* Apply discount codes (`SAVE10`, `SAVE20`).
* Create an order with a shipping address.
* After checkout, the cart is cleared, but the order remains unchanged.

What the Project Demonstrates

* **Structs** create independent copies of data — changes to one do not affect others.
* **Classes** use reference semantics — changes are shared across all references.
* **ShoppingCart (class)** acts as a shared, mutable object.
* **Order (struct)** is an immutable snapshot of the cart’s data.

What I Learned

* How to define and use **structs** and **classes** in Swift.
* How to use computed properties and methods effectively.
* How to work with `mutating func` in structs.
* How to encapsulate data using `private(set)`.
* How to structure simple business logic in Swift.

Program Result

The program creates several products, adds them to the cart, applies discounts, and creates an order.
The console output displays:

* List of products, quantities, and totals
* Applied discount
* Final total
* Order details and shipping address

After checkout, the cart is cleared — demonstrating the difference between a **class (reference type)** and a **struct (value type)** in action.

