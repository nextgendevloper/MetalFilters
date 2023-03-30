//
//  Strings+Ext.swift
//  IOS_CommonUtil
//
//  Created by Developer on 7/15/21.
//

import Foundation

public extension String {
    var floatValue: Float {
        return (self as NSString).floatValue
    }
    /// -returns: array of total lines in string
    var lines: [String] {
        var result: [String] = []
        enumerateLines { line, _ in result.append(line) }
        return result
    }
    
    
    /** will search for translation in main project and IOS_CommonUtil Library and returns translated text in current app language
 */
     func translate() -> String{
        
       var localizedString =  NSLocalizedString(self , comment: "")
       if(localizedString == self)||(localizedString.contains("_")){
    // print("Searching In POD Translation")
          // print("\(self) - translation not in MAIN")
           if let bundle = Resource.getPodBundle(for: "Localizable", ext: "strings") {
                           localizedString = NSLocalizedString(self, tableName: nil, bundle: bundle, value: "", comment: "")

           if(localizedString == self)||(localizedString.contains("_")){

                   print("\(self) - translation not in MAIN nor POD ")
               
           }else{
              // print("\(self) - translation FOUND IN POD ")
           }
           return localizedString;
    }


       }else{
           return localizedString
       }
           return self
       
    }
    
    
    /// Return String With Space added Before  Capital First Letter
    /// - Returns:
     func addSpaceBeforeCapital() -> String {
        
        return self
            .replacingOccurrences(of: "([a-z])([A-Z](?=[A-Z])[a-z]*)", with: "$1 $2", options: .regularExpression)
            .replacingOccurrences(of: "([A-Z])([A-Z][a-z])", with: "$1 $2", options: .regularExpression)
            .replacingOccurrences(of: "([a-z])([A-Z][a-z])", with: "$1 $2", options: .regularExpression)
            .replacingOccurrences(of: "([a-z])([A-Z][a-z])", with: "$1 $2", options: .regularExpression)
    }
    
     func separate(every stride: Int = 4, with separator: Character = " ") -> String {
        return String(enumerated().map { $0 > 0 && $0 % stride == 0 ? [separator, $1] : [$1]}.joined())
    }
    
    func toBool() -> Bool? {
        switch self {
        case "True", "true", "yes", "1","YES":
            return true
        case "False", "false", "no", "0","NO":
            return false
        default:
            return nil
        }
    }
    var isInteger : Bool {
        return Int(self) != nil
    }
    func getUInt() -> UInt? {
      
        return (UInt(self) != nil) ? UInt(self) : nil
        
    }
    
    
}

extension StringProtocol where Self: RangeReplaceableCollection {
    mutating public func insert(separator: Self, every n: Int) {
        for index in indices.reversed() where index != startIndex &&
            distance(from: startIndex, to: index) % n == 0 {
                insert(contentsOf: separator, at: index)
        }
    }
    
    public func inserting(separator: Self, every n: Int) -> Self {
        var string = self
        string.insert(separator: separator, every: n)
        return string
    }
    public var lines: [SubSequence] {
        return split { $0.isNewline }
    }
    public var removingAllExtraNewLines: String {
        return lines.joined(separator: "\n")
    }
}
