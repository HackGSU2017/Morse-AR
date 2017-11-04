//
//  MorseCode.swift
//  Morse AR
//
//  Created by Nate Thompson on 11/4/17.
//  Copyright © 2017 Nate Thompson. All rights reserved.
//

import Foundation

class MorseChar: NSObject {
    
    public var elements: String
    public var letter: String
    
    override public var description: String {
        return "\(letter): \(elements)"
    }
    
    init(elements: String) {
        self.elements = elements
        
        if elements == ".-" {
            letter = "a"
        } else if elements == "-..." {
            letter = "b"
        } else if elements == "-.-." {
            letter = "c"
        } else if elements == "-.." {
            letter = "d"
        } else if elements == "." {
            letter = "e"
        } else if elements == "..-." {
            letter = "f"
        } else if elements == "--." {
            letter = "g"
        } else if elements == "...." {
            letter = "h"
        } else if elements == ".." {
            letter = "i"
        } else if elements == ".---" {
            letter = "j"
        } else if elements == "-.-" {
            letter = "k"
        } else if elements == ".-.." {
            letter = "l"
        } else if elements == "--" {
            letter = "m"
        } else if elements == "-." {
            letter = "n"
        } else if elements == "---" {
            letter = "o"
        } else if elements == ".--." {
            letter = "p"
        } else if elements == "--.-" {
            letter = "q"
        } else if elements == ".-." {
            letter = "r"
        } else if elements == "..." {
            letter = "s"
        } else if elements == "-" {
            letter = "t"
        } else if elements == "..-" {
            letter = "u"
        } else if elements == "...-" {
            letter = "v"
        } else if elements == ".--" {
            letter = "w"
        } else if elements == "-..-" {
            letter = "x"
        } else if elements == "-.--" {
            letter = "y"
        } else if elements == "--.." {
            letter = "z"
        } else if elements == ".----" {
            letter = "1"
        } else if elements == "..---" {
            letter = "2"
        } else if elements == "...--" {
            letter = "3"
        } else if elements == "....-" {
            letter = "4"
        } else if elements == "....." {
            letter = "5"
        } else if elements == "-...." {
            letter = "6"
        } else if elements == "--..." {
            letter = "7"
        } else if elements == "---.." {
            letter = "8"
        } else if elements == "----." {
            letter = "9"
        } else if elements == "-----" {
            letter = "0"
        } else if elements == ".-.-.-" {
            letter = "."
        } else if elements == "--..--" {
            letter = ","
        } else if elements == "---..." {
            letter = ":"
        } else if elements == "..--.." {
            letter = "?"
        } else if elements == ".----." {
            letter = "'"
        } else if elements == "-....-" {
            letter = "-"
        } else if elements == "-..-." {
            letter = "/"
        } else if elements == ".-..-." {
            letter = "\""
        } else if elements == ".--.-." {
            letter = "@"
        } else if elements == "-...-" {
            letter = "="
        } else {
            letter = ""
        }
    }
}





