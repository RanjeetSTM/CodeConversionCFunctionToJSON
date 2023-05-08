//
//  File.swift
//  CodeGeneratorFromFunction
//
//  Created by Slab Noida on 14/04/21.
//

import Foundation
enum objectiveCTypes : String {
    case uint16_t
    case int16_t
    case BOOL
    case bool
    case uint8_t
    case int8_t
    case int32_t
    case uint32_t
}

indirect enum DataTypesConversion : String {
    
    case uint16_t = "UInt16"
    case int16_t = "Int16"
    case BOOL = "Bool"
    case uint8_t = "UInt8"
    case int8_t = "Int8"
    case int32_t = "Int32"
    case uint32_t = "UInt32"
    case any = "Any"
    
    
    
}
func checkParameter(strType : String) -> DataTypesConversion.RawValue {
    if strType == objectiveCTypes.uint16_t.rawValue {
        return DataTypesConversion.uint16_t.rawValue
    }
    else if strType == objectiveCTypes.uint8_t.rawValue {
        return DataTypesConversion.uint8_t.rawValue
    }
    else if strType == objectiveCTypes.uint32_t.rawValue {
        return DataTypesConversion.uint32_t.rawValue
    }
    else if strType == objectiveCTypes.int8_t.rawValue {
        return DataTypesConversion.int8_t.rawValue
    }
    else if strType == objectiveCTypes.int16_t.rawValue {
        return DataTypesConversion.int16_t.rawValue
    }
    else if strType == objectiveCTypes.int32_t.rawValue {
        return DataTypesConversion.int32_t.rawValue
    }
    else if strType == objectiveCTypes.BOOL.rawValue ||  strType == objectiveCTypes.bool.rawValue{
        return DataTypesConversion.BOOL.rawValue
    }
    else{
        return DataTypesConversion.any.rawValue
    }
}
