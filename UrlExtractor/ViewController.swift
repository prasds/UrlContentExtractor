//
//  ViewController.swift
//  UrlExtractor
//
//  Created by Prashanth Ds on 01/07/16.
//  Copyright © 2016 Prashanth Ds. All rights reserved.
//

import UIKit

class ViewController: UIViewController, NSURLConnectionDelegate {

    let defaultSession = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
    
    var dataTask: NSURLSessionDataTask?
    
    var query = String()
    var data: NSMutableData = NSMutableData()
    
    @IBOutlet weak var webAddress: UITextField!
    
    @IBOutlet weak var displayLabel: UILabel!
    
    @IBAction func submitButton(sender: UIButton) {
        print("button pressed")

            let urlPath: String = "http://54.153.121.25:8000/buildings"
            let url: NSURL = NSURL(string: urlPath)!
            let task = NSURLSession.sharedSession().dataTaskWithURL(url){
            
            (data, response, error) in
            
            let httpResponse: NSHTTPURLResponse = response as! NSHTTPURLResponse
            let statusCode = httpResponse.statusCode
            if statusCode == 200 {
                
                let webString = NSString(data: data!, encoding: NSUTF8StringEncoding)
                
                var replacedStr = webString!.stringByReplacingOccurrencesOfString("u'_id':", withString: "\"id\":")
                
                replacedStr = replacedStr.stringByReplacingOccurrencesOfString("':", withString: ":")
                
                replacedStr = replacedStr.stringByReplacingOccurrencesOfString("ObjectId('", withString: "\"")
                
                replacedStr = replacedStr.stringByReplacingOccurrencesOfString("')", withString: "\"")
                
                replacedStr = replacedStr.stringByReplacingOccurrencesOfString("u'", withString: "")
                
                replacedStr = replacedStr.stringByReplacingOccurrencesOfString("}{", withString: "},{")
                
                replacedStr = "{ \"places\": [" + replacedStr + "] }"
                
                print(replacedStr)
                
                let myNSString = replacedStr as NSString
                
                let myNSData = myNSString.dataUsingEncoding(NSUTF8StringEncoding)!
                
                
                do{
                    
                    let json = try NSJSONSerialization.JSONObjectWithData(myNSData, options:.AllowFragments)
                    
                    if let places = json["places"] as? [[String: AnyObject]] {
                        
                        for place in places {
                            
                            if let id  = place["id"] as? String {
                                
                                if let name = place["name"] as? String {
                                    print(id,name)
                                }
                                
                            }
                        }
                        
                    }
                    
                }catch {
                    print("Error with Json: \(error)")
                }


            
        }
        }
        
        task.resume()

        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

