import Foundation
import UIKit

public func printError(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
    //        #if DEVELOPMENT
    let className = file.components(separatedBy: "/").last
    print(" ❌ Error ----> File: \(className ?? ""), Function: \(function), Line: \(line), Message: \(message)")
    //        #endif
}

public func printSuccess(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
    //        #if DEVELOPMENT
    let className = file.components(separatedBy: "/").last
    print(" ✅ Success ----> File: \(className ?? ""), Function: \(function), Line: \(line), Message: \(message)")
    //        #endif
}

public func getImage(named: String, anyClass: AnyClass) -> UIImage? {
    let bundle = Bundle(for: anyClass)
    let image = UIImage(named: named, in: bundle, compatibleWith: nil)
    return image
}
