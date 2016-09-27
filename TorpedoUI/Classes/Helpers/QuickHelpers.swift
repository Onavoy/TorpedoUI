import Foundation


extension Array {
    
    func filter<T>(ofType type: T.Type) -> [T] {
        var result: [T] = []
        for element in self {
            if let element = element as? T {
                result.append(element)
            }
        }
        return result;
    }
    
}
