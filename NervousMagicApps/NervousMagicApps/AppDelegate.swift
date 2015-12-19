//
//  AppDelegate.swift
//  NervousMagicApps
//
//  Created by Sam Sulaimanov on 19/12/15.
//  Copyright © 2015 ethz. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var server = HttpServer()
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        do {
            try self.server.start()
            print("Server Started Successfully!")
        } catch {
            print("Server start error: \(error)")
        }
        
        //let jsonObject: String = "{" + "\"ID\"" + ":" + (NSString(format: "%d", 10) as String) + "," + "\"Class\"" + ":" + (NSString(format: "%d", 3) as String) + "}"
        self.server["/json"] = { request in
            let jsonObject: NSDictionary = [NSString(string: "foo"): NSNumber(int: 3), NSString(string: "bar"): NSString(string: "baz")]
            return .OK(.Json(jsonObject))
        }
        
        server["/test/:param1/:param2"] = { r in
            var headersInfo = ""
            for (name, value) in r.headers {
                headersInfo += "\(name) : \(value)<br>"
            }
            var queryParamsInfo = ""
            for (name, value) in r.queryParams {
                queryParamsInfo += "\(name) : \(value)<br>"
            }
            var pathParamsInfo = ""
            for token in r.params {
                pathParamsInfo += "\(token.0) : \(token.1)<br>"
            }
            return .OK(.Html("<h3>Address: \(r.address)</h3><h3>Url:</h3> \(r.url)<h3>Method: \(r.method)</h3><h3>Headers:</h3>\(headersInfo)<h3>Query:</h3>\(queryParamsInfo)<h3>Path params:</h3>\(pathParamsInfo)"))
        }

        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

