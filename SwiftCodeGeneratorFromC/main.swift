//
//  main.swift
//  SwiftCodeGeneratorFromC
//
//  Created by Ranjeet Singh on 07/03/23.
//

import Foundation


//MARK: Read Functions From Data File





//MARK: Conversion of functions to swift functions

let cFunctionExample = "Result GenericOnOffSet(uint16_t peerAddress, bool isOn, uint8_t transitionTime, uint8_t delay, bool isUnacknowledged)"

let chatGPTExampleDemo = "Result GenericOnOffSet(uint16_t peerAddress, bool isOn, uint8_t transitionTime)"






struct Convert_C_CodeToJSON : WriteTextToFile{
    
    
    private var functionsToConvert : Array<String> = []
    private var functionsCountToConvert = -1
    
    mutating func retrieveFunctionFromDataFile() -> Array<String>{
        guard let functionsValue = readFileFromDataFile(strFileName: "DataFile") else {
            print("Nothing could be read from the file ")
            functionsCountToConvert = -1
            return [""]
        }
        print(functionsValue)
        functionsToConvert = functionsValue
        functionsCountToConvert = functionsValue.count
        return functionsValue
    }
    
    func CreateJSONFromFunction (_ input : String) -> [String: Any] {
        let components : [String] = input.components(separatedBy: "(")
        let returnAndFunctionType = components[0].components(separatedBy: " ")
        let returnType = returnAndFunctionType[0]
        let functionName = returnAndFunctionType[1]
        let paramsArguments = components[1].replacingOccurrences(of: ")", with: "")
        
        

        let params = paramsArguments.components(separatedBy: ", ").map { param in
            let typeAndName = param.components(separatedBy: " ")
            let type = typeAndName[0]
            let name = typeAndName[1]
            
            return ["type": type , "paramName": name]
        }
        
        let json: [String: Any] = [
            "returnType": returnType,
            "functionName": functionName,
            "params": params
        ]
        
        return json
        
    }
    
    func convertStringToJSONObject(strJSON : [String: Any]) -> String {
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: strJSON, options: .prettyPrinted)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                return jsonString
            }
        } catch {
            print("Error converting dictionary to string: \(error.localizedDescription)")
           
        }
        return ""
    }
    
    
    func writeJSONToFile(json : [String : Any]) {
        if let fileURL = Bundle.main.url(forResource: "FunctionJSON", withExtension: "json") {
            do {
                print(fileURL)
                let jsonData = try JSONSerialization.data(withJSONObject: json, options: [.prettyPrinted])
                try jsonData.write(to: fileURL)
            } catch {
                print("Error writing JSON data: \(error.localizedDescription)")
            }
        }else {
            
        }
        
    }
    func convertRetrievedFunctionsToJSON(strFunctions : [String]) {
        Convert_C_CodeToJSON.write(toFile: "Demo", withExtension: "json", writeText: "[")
        for eachFunction in strFunctions {
            _ = Convert_C_CodeToJSON.write(toFile: "Demo", withExtension: "json", writeText: convertStringToJSONObject(strJSON: CreateJSONFromFunction(eachFunction)).appending(","))
        }
        Convert_C_CodeToJSON.write(toFile: "Demo", withExtension: "json", writeText: "]")

    }

}


var objConvert_C_CodeToJSON = Convert_C_CodeToJSON()
Convert_C_CodeToJSON.delete(file: "Demo", withExtension: "json")
objConvert_C_CodeToJSON.convertRetrievedFunctionsToJSON(strFunctions: objConvert_C_CodeToJSON.retrieveFunctionFromDataFile())



// read function as json from jsonFile

let functionJSON = parseModel(filePath: Convert_C_CodeToJSON.getFileURL(fileName: "Demo", fileExetension: "json"))
print(functionJSON)



func writeSwiftCode() {
    
    for eachFunction in functionJSON {
        let paramStrings = eachFunction.params.map { "\($0.paramName): \($0.swiftType)" }
        let paramString = paramStrings.joined(separator: ", ")
//        print( "func \(eachFunction.functionName.lowercased())(\(paramString)) -> \(eachFunction.returnType) \n")
//        
//        Convert_C_CodeToJSON.write(toFile: "Function", withExtension: "swift", writeText:         "public func \(eachFunction.functionName.lowercased())(\(paramString)) -> \(eachFunction.returnType) {} \n")
        
        var functionName = eachFunction.functionName
        functionName = functionName.camelCase()
        Convert_C_CodeToJSON.write(toFile: "Function", withExtension: "swift", writeText:         "public func \(eachFunction.functionName.lowercaseFirstLetter())(\(paramString)) -> Mesh\(eachFunction.returnType) { return 1} \n")

        Convert_C_CodeToJSON.write(toFile: "PrivateFunction", withExtension: "swift", writeText:         "private func hidden\(eachFunction.functionName)(\(paramString)) -> Mesh\(eachFunction.returnType) { return 1} \n")


    }
}
Convert_C_CodeToJSON.delete(file: "Function", withExtension: "swift")

print(writeSwiftCode())
    
