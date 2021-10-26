import Foundation

extension String {
    
    func toDate() -> Date? {
        if self.isEmpty {
            return nil
        }
        
        return dateFormatter.date(from: self)
    }
}
