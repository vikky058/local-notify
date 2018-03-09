//
//  ViewController.swift
//  codable-decodable
//
//  Created by Vikky Chaudhary on 17/02/18.
//  Copyright © 2018 Vikky Chaudhary. All rights reserved.
//

import UIKit

struct blog:Decodable {
    let kind:String
    let items:[items]
}

struct items:Decodable {
    var content :String
    var selfLink:String
}
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func Decode(_ sender: Any) {
        let url=URL(string: "https://www.googleapis.com/blogger/v3/blogs/10861780/posts?key=AIzaSyDZpaBWqUymU3M9pxbigjtgNlIAQJGbITg")
        let task = URLSession.shared.dataTask(with: url!) { (data, responce, error) in
            if error == nil{
                if let urldata = data{
                    do{
                        let decodedData = try JSONDecoder().decode(blog.self, from: urldata)
                       // print(decodedData)
                        for it in 0...(decodedData.items.count - 1){
                            print(decodedData.items[it].content)
                            print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@")
                            
                        }
                        
                    }catch{
                        print(error)
                    }
                }
            }
        }
        task.resume()
        
    }
    
}

