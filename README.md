# Code-Convertor-C++-to-JSON
So this codebase will convert the function which you written in the C++ and it will yield the json to you, containing keys and values of each individual parts of a function, File will be written on the desktop in the folder name "FileGeneratedFolder".
For this code base I have used it for my purpose, I have also consumed the JSON and converted the code to Swift, similarly, we can provide an input JSON to any code generator which will write the code in the desired language but you have to write the code for it. I have written the code for SWIFT which you can check for your reference.


#How to use it?
* Basically, in the Data file you will write the entire blueprints of the C++ functions.
* Then, run the code, it will yield JSON to you in the "File Generated Folder".
* Those who want to check the Swift Generated Function power pack, it is residing in the same folder.


#For Example

In the data file you have provided with the, 

** int demoFunction(uint16_t param1, bool param2, uint8_t param3);**

Once you run the code, it will yield you.

**[{
  "params" : [
    {
      "paramName" : "param1",
      "type" : "uint16_t"
    },
    {
      "paramName" : "param2",
      "type" : "bool"
    },
    {
      "type" : "uint8_t",
      "paramName" : "param3"
    }
  ],
  "returnType" : "int",
  "functionName" : "demoFunction"
},{
  "functionName" : "checkingFunction",
  "returnType" : "int",
  "params" : [
    {
      "type" : "int",
      "paramName" : "param1"
    },
    {
      "type" : "bool",
      "paramName" : "param2"
    },
    {
      "paramName" : "param3",
      "type" : "float"
    }
  ]
},]
**

* Above generated result, you can consume it for any programatic language and, you can use this JSON and can budle up in your own proficient language.
