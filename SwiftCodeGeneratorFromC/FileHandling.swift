//
//  WriteText.swift
//  SwiftFileGenerator
//
//  Created by Slab Noida on 19/01/21.
//

//import UIKit
import Foundation


protocol WriteTextToFile{
    static func write(toFile: String , withExtension ext : String, writeText: String) -> Bool
    @discardableResult static func delete(file : String , withExtension ext : String) -> Bool
    static func getFileURL (fileName : String , fileExetension : String) -> URL
}
extension WriteTextToFile {
    static var desktopURL : URL {
        get {return try! FileManager.default.url(for: .desktopDirectory, in: .userDomainMask, appropriateFor: nil, create: true)}
   }
}
extension WriteTextToFile {
    static func getFileURL (fileName : String , fileExetension : String) -> URL{
        return desktopURL.appendingPathComponent("FileGeneratedFolder/").appendingPathComponent(fileName).appendingPathExtension(fileExetension)
    }
    static func write(toFile: String , withExtension ext : String, writeText: String) -> Bool {        
        print("desktopURL: " + String(describing: desktopURL))
        let fileURL = getFileURL(fileName: toFile, fileExetension: ext)
        print("File Path: \(fileURL.path)")
            if FileManager.default.fileExists(atPath: fileURL.path) {
                if let fileHandle = try? FileHandle(forWritingTo: fileURL) {
                        fileHandle.seekToEndOfFile()
                        fileHandle.write(writeText.data(using: .utf8)!)
                        fileHandle.closeFile()
                    }
                } else {
                    do {
                        try writeText.write(to: fileURL, atomically: true, encoding: String.Encoding.utf8)
                    } catch let error as NSError {
                        print("Error: fileURL failed to write: \n\(error)" )
                        return false
                    }
                }
        return true
    }
    @discardableResult static func delete(file : String , withExtension ext : String) -> Bool{
        let fileURL = getFileURL(fileName: file, fileExetension: ext)
        if FileManager.default.fileExists(atPath: fileURL.path){
            do {
                try FileManager.default.removeItem(atPath: fileURL.path)
            }catch let error as NSError {
                print("Error: fileURL failed to delete: \n\(error)" )
                return false
            }
        }
        else{
            return false
        }
        return true
    }
}



//MARK: Read File

func readFileFromDataFile(strFileName : String) -> Array<String>?{
    let path = Bundle.main.path(forResource: strFileName, ofType: "txt") // file path for file "data.txt"
    do{
        var string = try String(contentsOfFile: path!, encoding: String.Encoding.utf8)
        var arrFunctionsCount = string.components(separatedBy: ";").map({$0.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)})
        arrFunctionsCount = arrFunctionsCount.filter({$0.count > 0})
        print(arrFunctionsCount)
        
        
//        string = string.trimmingCharacters(in: CharacterSet.whitespaces)
//        string = string.replacingOccurrences(of: ";", with: "")
        print(string)
        return arrFunctionsCount
    }
    catch {
        print(error)
        return nil
    }
}


func parseModel (filePath : URL) -> Function{
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase 
    var jsonData : String = ""
//    if let filepath = Bundle.main.path(forResource: "Draft", ofType: "json") {
        do {
            var contents = try String(contentsOf: filePath)
            contents = contents.replacingOccurrences(of: ",]", with: "]")

            print(contents)
            jsonData = contents
        } catch {
            // contents could not be loaded
            return Function()

        }
        if let jsonData =   jsonData.data(using: .utf8) {
            
            do {
                let modelGenerator = try decoder.decode(Function.self, from: jsonData)
                print("Model generated was:",modelGenerator)
                return modelGenerator
            } catch {
                print(error)
                return Function()

            }
        }
//    }
    return Function()

}
