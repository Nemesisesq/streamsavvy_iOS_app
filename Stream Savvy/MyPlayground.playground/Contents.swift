//: Playground - noun: a place where people can play

import UIKit
import JavaScriptCore
var str = "Hello, playground"


let fileURL = Bundle.main.url(forResource: "lodash", withExtension: "js")
let content = try String(contentsOf: fileURL!, encoding: String.Encoding.utf8)


let context = JSContext()

context?.evaluateScript(content)

context?.evaluateScript("_.map")

let x = context?.evaluateScript("_.sortBy([5,3, 8, 9, 10, 1])")

