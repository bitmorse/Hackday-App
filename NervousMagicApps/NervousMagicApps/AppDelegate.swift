//
//  AppDelegate.swift
//  NervousMagicApps
//
//  Created by Sam Sulaimanov on 19/12/15.
//  Copyright © 2015 ethz. All rights reserved.
//

import UIKit
import CoreMotion

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var server = HttpServer()
    let manager = CMMotionManager()
    
    var jsnsense: NSDictionary = [NSString(string: "version"): NSNumber(double: 1.0)]
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        
        do {
            try self.server.start()
            print("Server Started Successfully!")
        } catch {
            print("Server start error: \(error)")
        }
        
        //let jsonObject: String = "{" + "\"ID\"" + ":" + (NSString(format: "%d", 10) as String) + "," + "\"Class\"" + ":" + (NSString(format: "%d", 3) as String) + "}"
        //self.server["/json"] = { request in
        //    let jsonObject: NSDictionary = [NSString(string: "foo"): NSNumber(int: 3), NSString(string: "bar"): NSString(string: "baz")]
        //    return .OK(.Json(jsonObject))
        //}
        
        
        let publicDir = NSBundle.mainBundle().resourcePath;

        
        
        server.GET["/nervous-jsapps/:appname/:resource"] = { r in
            let filename = r.params["resource"];
            let appfilename = r.params["appname"];
            
            if let rootDir = publicDir, html = NSData(contentsOfFile:"\(rootDir)/nervous-jsapps/\(appfilename!)/\(filename!)") {
                var array = [UInt8](count: html.length, repeatedValue: 0)
                html.getBytes(&array, length: html.length)
                
                return HttpResponse.RAW(200, "OK", nil, array)
            }
        return .NotFound
        }
        
        server.GET["/nervous-resources/:resource"] = { r in
            let filename = r.params["resource"];
            
            if let rootDir = publicDir, html = NSData(contentsOfFile:"\(rootDir)/nervous-resources/\(filename!)") {
                var array = [UInt8](count: html.length, repeatedValue: 0)
                html.getBytes(&array, length: html.length)
                
                return HttpResponse.RAW(200, "OK", nil, array)
            }
            return .NotFound
        }
        
        
        server.GET["/nervous-api/:resource/:method"] = {r in
            
            let resource = r.params["resource"];
            let method = r.params["method"];
            
            
            switch resource! {
                case "acc":
                    self.manager.accelerometerUpdateInterval = 0.005
                    self.manager.startAccelerometerUpdates()
                    if method! == "getAcc" {
                        if self.manager.accelerometerAvailable {
                            self.manager.startAccelerometerUpdatesToQueue(NSOperationQueue()) { (data: CMAccelerometerData?, error: NSError?) in
                                guard data != nil else {
                                    print("There was an error: \(error)")
                                    return
                                }
                                //let ax = "\"x\"" + ":" + (NSString(format: "%f", data!.acceleration.x) as String)
                                //let ay = "\"y\"" + ":" + (NSString(format: "%f", data!.acceleration.y) as String)
                                //let az = "\"z\"" + ":" + (NSString(format: "%f", data!.acceleration.z) as String)
                                //self.jsnsense = "{" + ax + "," + ay + "," + az + "}"
                                self.jsnsense = [NSString(string: "x"): NSNumber(double: data!.acceleration.x), NSString(string: "y"): NSNumber(double: data!.acceleration.y),NSString(string: "z"): NSNumber(double: data!.acceleration.z)]
                                //print(self.jsnsense)
                                self.manager.stopAccelerometerUpdates()
                            }
                        }
                        NSThread.sleepForTimeInterval(0.2)
                    }
                
                case "gyr":
                    self.manager.gyroUpdateInterval = 0.005
                    self.manager.startGyroUpdates()
                    if method! == "getGyr" {
                        if self.manager.gyroAvailable {
                            self.manager.startGyroUpdatesToQueue(NSOperationQueue()) { (data: CMGyroData?, error: NSError?) in
                                guard data != nil else {
                                    print("There was an error: \(error)")
                                    return
                                }
                                //let gx = "\"x\"" + ":" + (NSString(format: "%f", data!.rotationRate.x) as String)
                                //let gy = "\"y\"" + ":" + (NSString(format: "%f", data!.rotationRate.y) as String)
                                //let gz = "\"z\"" + ":" + (NSString(format: "%f", data!.rotationRate.z) as String)
                                //self.jsnsense = "{" + gx + "," + gy + "," + gz + "}"
                                self.jsnsense = [NSString(string: "x"): NSNumber(double: data!.rotationRate.x), NSString(string: "y"): NSNumber(double: data!.rotationRate.y),NSString(string: "z"): NSNumber(double: data!.rotationRate.z)]
                                //print(self.jsnsense)
                                self.manager.stopGyroUpdates()
                                
                            }
                        }
                        NSThread.sleepForTimeInterval(0.5)
                }
                
                default:
                    self.jsnsense = [NSString(string: "version"): NSNumber(double: 1.0)]
            }
            
            print(self.jsnsense)
            //return .OK(.Html("<h3>hello:</h3>\(resource!)\(method!)"))
            return .OK(.Json(self.jsnsense))
            //return .OK(.Html("<h3>hello:</h3>\(self.jsnsense)"))

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

