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

extension LinkedList: CustomStringConvertible {
    var description: String {
        guard let head = head else {
            return "Empty list"
        }
        return String(describing: head)
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
