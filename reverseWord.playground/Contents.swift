import UIKit

func reverseWord(line:String)->String{
    let allwords = line.components(separatedBy: " ")
    var newSentence = ""
    for word in allwords{
        if newSentence != ""{
            newSentence += " "
        }
        let rev = String(word.reversed())
        newSentence += rev
    }
    return newSentence
}
reverseWord(line: "A good day to die hard")
