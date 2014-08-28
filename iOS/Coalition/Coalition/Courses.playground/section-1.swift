// Playground - noun: a place where people can play

import Cocoa

let resourcePath = NSBundle.mainBundle().resourcePath
//var error = NSError
let documents = NSFileManager.defaultManager().contentsOfDirectoryAtPath("coursera_videos", error: nil)

documents
