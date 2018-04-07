//
//  AppDelegate.swift
//  Telegraph_Test
//
//  Created by Administrator on 05/04/2018.
//  Copyright © 2018 mahesh lad. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var articles: [CollectionViewModel] = []

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
    
            self.parsejson()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Telegraph_Test")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    //---
    func parsejson() {
         self.articles = []
          var collectionVM : [CollectionViewModel] = []
        let url = URL(string: "http://s.telegraph.co.uk/tmgmobilepub/articles.json")
        var request = URLRequest(url:url!)
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        let task =   URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            print("request response")
            print(response)
            guard let _:Data = data, let _:URLResponse = response  , error == nil else {
                print("error")
                return
            }
           // var collections : [Collection] = []
          
            let jsonString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            //     print(dataString!)
            let data = jsonString?.data(using: String.Encoding.utf8.rawValue)
            do {  let dic = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
             //   print(dic)
                let collectionArray = dic["collection"] as! [NSDictionary]
                for col in collectionArray {
                    //print(col["description"]!)
                    //  print(collectionArray[0]["id"]!)
                    //     print(collectionArray[0]["description"]!)
                    print(col["author"]!)
                    let authorName =  (col.value(forKeyPath:"author.name") as? String)!
                    let authorHeadshot = (col.value(forKeyPath:"author.headshot") as? String)!
                    let authorTwitter = (col.value(forKeyPath:"author.twitter") as? String)!
                    
                    let au =  author(name: authorName as! String, headshot: authorHeadshot as! String, twitter: authorTwitter as! String)
                    let collection = Collection(id: col["id"]  as! Int, websiteUrl: col["website-url"] as? URL, headline: col["headline"] as? String, description: col["description"] as? String, articleBody: col["article-body"] as? String, ratings: col["ratings"] as! Int, pictureUrl: col["picture-url"] as? String, videoUrl: col["video-url"] as? URL, actors: col["actors"] as! [String] , director: col["director"] as? String, genre: col["genre"] as! [String], synopsis: col["synopsis"] as? String, releaseDate: col["release-date"] as! String, duration: col["duration"] as? String, publishedDate: col["published-date"] as? String, author: au  ) as Collection

                    self.articles.append(CollectionViewModel(collection: collection))
               
                }
                DispatchQueue.main.async {
                  print(self.articles.count)
                  NotificationCenter.default.post(name: Notification.Name("didFinishDownloading"), object: nil)
                }
            } catch  {
                print(error)
            }
            
        }
        
        task.resume()
    
    }
    //---
}

