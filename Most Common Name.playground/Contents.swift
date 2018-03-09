import UIKit

func mostcommanname(array:[String]) -> String{
    
    var namecountdict = [String:Int]()
    for name in array{
        if let count = namecountdict[name]{
            namecountdict[name] = count + 1
        }else{
            namecountdict[name] = 1
        }
    }
    var mostcommon = ""
    for key in namecountdict.keys{
        if mostcommon == ""{
            mostcommon = key
        }else{
            let count = namecountdict[key]
            if count! > namecountdict[mostcommon]!{
                mostcommon = key
            }
        }
        print("\(key) \(namecountdict[key]!)")
    }
    
    return mostcommon
}
mostcommanname(array: ["vikky","amit","vikky","ankit","ajay","ajay","ajay"])

