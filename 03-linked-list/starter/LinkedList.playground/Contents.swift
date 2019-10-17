// Copyright (c) 2018 Razeware LLC
// For full license & permission details, see LICENSE.markdown.


// MARK: - Node

class Node<Value> {
    
    var value: Value
    var next: Node?
    
    init(value: Value, next: Node? = nil) {
        self.value = value
        self.next = next
    }
}

extension Node: CustomStringConvertible {
    
    var description: String {
        guard let next = next else {
            return "\(value)"
        }
        return "\(value) -> \(next)"
    }
}

example(of: "Linked list") {
    let node1 = Node(value: 1)
    let node2 = Node(value: 2)
    let node3 = Node(value: 3)
    node1.next = node2
    node2.next = node3
    
    print(node1)
}

// MARK: - Link

struct LinkedList<Value> {
    var head: Node<Value>?
    var tail: Node<Value>?
    init() {
        
    }
    
    var isEmpty: Bool {
        return head == nil
    }
}

extension LinkedList: CustomStringConvertible {
    var description: String {
        guard let head = head else {
            return "Empty list"
        }
        return String(describing: head)
    }
}

// Adding valur to list

extension LinkedList {
    
    // O(1)
    mutating func push(_ value: Value) {
        head = Node(value: value, next: head)
        if tail == nil {
            tail = head
        }
    }
    
    // O(1)
    mutating func append(_ value: Value) {
        guard !isEmpty else {
            push(value)
            return
        }
        tail?.next = Node(value: value, next: nil)
        tail = tail?.next
    }
    
    // O(n)
    func node(at index: Int) -> Node<Value>? {
        var current = head
        var currentIndex = 0
        while current != nil && currentIndex < index {
            current = current!.next
            currentIndex += 1
        }
        return current
    }
    
    // O(1)
    @discardableResult mutating func insert(_ value: Value, after node: Node<Value>) -> Node<Value> {
        guard tail !== node else {
            append(value)
            return tail!
        }
        node.next = Node(value: value, next: node.next)
        return node.next!
    }
}

// Removing values
extension LinkedList {
    
    // O(1) 考虑边界问题
    @discardableResult mutating func pop() -> Value? {
        defer {
            head = head?.next
            if isEmpty {
                tail = nil
            }
        }
        return head?.value
    }
    
    // O(n)
    @discardableResult mutating func removeLast() -> Value? {
        guard let head = head else {
            return nil
        }
        guard head.next != nil else {
            return pop()
        }
        
        // Need know last and second last, so need to references
        var prev = head
        var current = head
        
        while let next = current.next {
            prev = current
            current = next
        }
        
        prev.next = nil
        tail = prev
        
        return current.value
    }
    
    // O(1)
    @discardableResult mutating func remove(after node: Node<Value>) -> Value? {
        defer {
            if node.next === tail {
                tail = node
            }
            node.next = node.next?.next
        }

        return node.next?.value
    }
        
}


example(of: "push") {
    var list = LinkedList<Int>()
    list.push(3)
    list.push(2)
    list.push(1)
    print(list)
}

example(of: "append") {
    var list = LinkedList<Int>()
    list.append(1)
    list.append(2)
    list.append(3)
    print(list)
}

example(of: "insert at a particular index") {
    var list = LinkedList<Int>()
    list.append(1)
    list.append(2)
    list.append(3)
    print("before insert: \(list)")
    let middleNode = list.node(at: 1)!
    for _ in 1...4 {
        list.insert(10, after: middleNode)
    }
    print("after insert: \(list)")

}

example(of: "pop") {
    var list = LinkedList<Int>()
    list.push(3)
    list.push(2)
    list.push(1)
    print("before pop: \(list)")
    let popedValue = list.pop()
    print("after pop: \(list)")
    print("poped value: \(String(describing: popedValue))")

}


example(of: "remove last") {
    var list = LinkedList<Int>()
    list.push(3)
    list.push(2)
    list.push(1)
    print("before remove last: \(list)")
    let lastValue = list.removeLast()
    print("after pop: \(list)")
    print("last remove last: \(String(describing: lastValue))")

}

example(of: "remove node at a particular index") {
    var list = LinkedList<Int>()
    list.append(1)
    list.append(2)
    list.append(3)
    list.append(4)
    list.append(5)
    print("before remove: \(list)")
    
    let index = 1
    let node = list.node(at: index)!
    let removedNode = list.remove(after: node)

    print("after remove: \(list)")
    print("removed node: \(String(describing: removedNode))")


}
