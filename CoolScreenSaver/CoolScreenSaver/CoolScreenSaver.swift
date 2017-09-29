//
//  CoolScreenSaver.swift
//  CoolScreenSaver
//
//  Created by zhw on 2017/9/27.
//  Copyright © 2017年 zhw. All rights reserved.
//

import Cocoa
import ScreenSaver


struct TextFieldSet {
    var x: CGFloat?
    var y: CGFloat?
    var h: CGFloat?
    var field: NSTextField?
    var speed: CGFloat?
}
class CoolScreenSaver: ScreenSaverView {
    var words:[String] = [String]()
    var textField: [TextFieldSet] = [TextFieldSet]()
    let linesOfLetters = 100
    override init?(frame: NSRect, isPreview: Bool) {
        super.init(frame: frame, isPreview: isPreview)
        
        for _ in 0..<linesOfLetters {
            let str = randomString(Int(SSRandomIntBetween(10, 50)))
            self.words.append(str)
        }
        
        self.animationTimeInterval = 1/60
        self.words.forEach{ word in
            self.collectTextField(word)
        }
    }
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
    }
    override func startAnimation() {
        super.startAnimation()
    }
    override func stopAnimation() {
        super.stopAnimation()
    }
    override func animateOneFrame() {
        self.subviews.removeAll()
        updateTextPosition()
    }
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
    }
    private func makeTextField(_ character: NSString) -> (field: NSTextField, x: CGFloat, y: CGFloat, h: CGFloat, speed: CGFloat){
        
        let letterX = SSRandomFloatBetween(0, self.bounds.width)
        let letterY = SSRandomFloatBetween(0, self.bounds.height)
        let rect = NSMakeRect(
            letterX,
            letterY,
            20,
            self.bounds.height)
        
        let letter: NSTextField = NSTextField(
            frame: rect)
        
        letter.lineBreakMode = .byCharWrapping
        letter.isEditable = false
        letter.isBordered = false
        letter.alignment = .center
        letter.backgroundColor = .clear
        letter.font = NSFont(name: "Raleway-Medium", size: SSRandomFloatBetween(14, 20))
        letter.stringValue = character as String
        letter.textColor = .green
        letter.stringValue = character as String
        letter.alphaValue = SSRandomFloatBetween(0, 1)
     
        return (field: letter, x: letterX, y: letterY, h: self.bounds.height, speed: SSRandomFloatBetween(10, 30))
    }
    private func collectTextField(_ words: String){
        let character = words.characters.map{String($0)}
        let ret = character.joined(separator: "\n")
        let letter = self.makeTextField(NSString(string: ret))
        let textField = TextFieldSet(x: letter.x, y: letter.y,  h: letter.h, field: letter.field, speed: letter.speed)
        self.textField.append(textField)
    }
    private func updateTextPosition(){
        for index in 0..<self.textField.count {
            var text = self.textField[index]
            if let field = text.field{
                if text.y! < -text.h!{
                    text.y = self.bounds.height + text.h!
                }
                text.y! -= text.speed!
                self.textField[index].y = text.y!
                
                field.frame = NSMakeRect(text.x!, text.y!, 20, text.h!)
                
                self.addSubview(field)
                self.setNeedsDisplay(field.frame)
                self.needsDisplay = true
            }
        }
    }
    private func randomString(_ length: Int) -> String{
        let str = "abcdefghigklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYA0123456789"
        var randomStr = ""
        
        for _ in 0..<length{
            let index = SSRandomIntBetween(0, Int32(str.count - 1))
            randomStr += String(str[str.index(str.startIndex, offsetBy: Int(index))])
        }
        return randomStr
    }
}

