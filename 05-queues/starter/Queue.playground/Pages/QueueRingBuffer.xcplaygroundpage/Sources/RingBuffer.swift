public struct RingBuffer<T> {
  
  private var array: [T?] = []
  private var readIndex = 0
  private var writeIndex = 0
  
  public init(count: Int) {
    array = Array<T?>(repeating: nil, count: count)
  }
  
  public var first: T? {
    return array[readIndex]
  }
  
  public mutating func write(_ element: T) -> Bool {
    if !isFull {
      array[writeIndex % array.count] = element
      writeIndex += 1
      return true
    } else {
      return false
    }
  }
  
  public mutating func read() -> T? {
    if !isEmpty {
      let element = array[readIndex % array.count]
      readIndex += 1
      return element
    } else {
      return nil
    }
  }
  
  private var availableSpaceForReading: Int {
    return writeIndex - readIndex
  }
  
  public var isEmpty: Bool {
    return availableSpaceForReading == 0
  }
  
  private var availableSpaceForWriting: Int {
    return array.count - availableSpaceForReading
  }
  
  public var isFull: Bool {
    return availableSpaceForWriting == 0
  }
}

extension RingBuffer: CustomStringConvertible {
  
  public var description: String {
    var result = "["
    var index = readIndex
    
    while index != (writeIndex % array.count) {
      
      if let value = array[index] {
        result += "\(value) "
      }
      
      if index == array.count - 1 {
        index = 0
      } else {
        index += 1
      }
    }
    
    result += "]"
    
    return result
  }
}
