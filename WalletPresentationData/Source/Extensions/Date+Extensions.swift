import Foundation

extension Date {
    
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        formatter.timeZone = NSTimeZone.local
        return formatter
    }()
    
    static public func currentDate() -> String {
        let date = Date()
        return dateFormatter.string(from: date)
    }
    
    public func stringFromDate() -> String {
        return Date.dateFormatter.string(from: self)
    }
    
    static public func dateFromString(_ string: String) -> Date? {
        return dateFormatter.date(from: string)
    }
}
