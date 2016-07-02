//
//  ViewController.swift
//  UrlExtractor
//
//  Created by Prashanth Ds on 01/07/16.
//  Copyright © 2016 Prashanth Ds. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let defaultSession = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
    
    var dataTask: NSURLSessionDataTask?
    
    var query = String()
    var data: NSMutableData = NSMutableData()
    
    @IBOutlet weak var webAddress: UITextField!
    
    @IBOutlet weak var displayLabel: UILabel!
    
    @IBAction func submitButton(sender: UIButton) {
        print("button pressed")
        

        
        //displayLabel.text = webAddress.text
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        let inputUrl = NSURL(string: "http://"+(webAddress?.text)!)
        
        print(inputUrl)
        
        do {
            let htmlSource = try String(contentsOfURL: inputUrl!, encoding: NSUTF8StringEncoding)
            print(htmlSource)
            displayLabel.text = htmlSource
        }
        catch let error as NSError {
            print("Ooops! Something went wrong: \(error)")
        }

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

