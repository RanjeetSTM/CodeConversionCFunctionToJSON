// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let function = try? JSONDecoder().decode(Function.self, from: jsonData)

import Foundation

// MARK: - FunctionElement
struct FunctionElement: Codable {
    let functionName: String
    let params: [Param]
    let returnType: String
}

// MARK: - Param
struct Param: Codable {
    let type: String
    let paramName: String
    
    var swiftType: String {
        switch type {
        case "bool":
            return "Bool"
            
        case "uint8_t":
            return "UInt8"
        case "int8_t":
            return "Int8"
            
        case "uint16_t":
            return "UInt16"
        case "int16_t":
            return "Int16"
            
        case "int32_t":
            return "Int32"
        case "uint32_t":
            return "UInt32"
            
        case "uint64_t":
            return "UInt64"
        case "int64_t":
            return "Int64"
        default:
            return "UInt64"
        }
    }
}



typealias Function = [FunctionElement]
