import Foundation

extension Date {
    func toDateString() -> String {
        return dateFormatter.string(from: self)
    }
}

let dateFormatter: DateFormatter = {
    var formatter = DateFormatter()
    formatter.dateStyle = .medium
    return formatter
}()
