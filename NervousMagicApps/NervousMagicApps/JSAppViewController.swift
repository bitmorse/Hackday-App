//
//  JSAppViewController.swift
//  NervousMagicApps
//
//  Created by Sam Sulaimanov on 19/12/15.
//  Copyright © 2015 ethz. All rights reserved.
//

//  Description: Handles flow between JSApp (Webview) and iOS app

import UIKit

class JSAppViewController: UIViewController {
    
    
    @IBOutlet weak var JSAppWebView: UIWebView!
    //Webviewcontroller scheme calls
    
    override func viewWillAppear(animated: Bool) {
        //hide status bar
        UIApplication.sharedApplication().setStatusBarHidden(true, withAnimation: UIStatusBarAnimation.Fade);
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //test webview

        //let url = NSURL(string: "http://localhost:8080/api"); //"https://sid027.github.io/Hackday-App/hello-world/app.html");

        let url = NSURL(string: "https://sid027.github.io/Hackday-App/hello-world/app.html");

        let request = NSURLRequest(URL: url!);
        JSAppWebView.loadRequest(request);
        JSAppWebView.scrollView.bounces = false;
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

