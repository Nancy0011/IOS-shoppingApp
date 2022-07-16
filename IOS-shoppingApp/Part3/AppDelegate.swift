//
//  AppDelegate.swift
//  Part3
//
//  Created by z on 31/10/21.
//

import UIKit
import SQLite3

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    let deleteDB = false

    var ShoppingArray:[Shopping] = []
    func getDBPath() ->String
    {
        let paths =
            NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask,true)
        let documentsDir = paths[0]
        let databasePath = (documentsDir as NSString).appendingPathComponent("Shopping.db")
        return databasePath;
    
    }
    // Copy the database to the device from the project folder
    
    func copyDatabase() {
        let fileManager = FileManager.default
        let dbPath = getDBPath()
        var success = fileManager.fileExists(atPath: dbPath)
        
        if(!success) {
            if let defaultDBPath = Bundle.main.path(forResource: "Shopping", ofType:"db"){
                
                var error:NSError?
                do {
                    try fileManager.copyItem(atPath: defaultDBPath, toPath: dbPath)
                    success = true
                }
                catch let error1 as NSError {
                    error = error1
                    success = false
                }
                print(defaultDBPath)
                if (!success){
                    print("Failed to create writable database file with message\(error!.localizedDescription))")
                }
            
            }else{
                print("File Already Exist At:\(dbPath)")
            }
        }
    }
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        if(deleteDB){
            deleteDatabase()
        }
        copyDatabase()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    //itemName: String, itemPrice: Double, itemType: String, quantity:Int
    func insertQuery(shopping:Shopping)->Bool {
        var db:OpaquePointer? = nil
        var isOK = false
        let insertSQL = "INSERT INTO shoppinglist(itemName, itemPrice, itemType, quantity) VALUES ('\(shopping.itemName)',\(shopping.itemPrice),'\(shopping.itemType)',\(shopping.quantity))"
        print(insertSQL)
        var queryStatement: OpaquePointer? = nil
        if sqlite3_open(getDBPath(),&db)==SQLITE_OK
        {
            
            print("Sucessfully opened connection to database ")
            
            if (sqlite3_prepare_v2(db, insertSQL, -1, &queryStatement, nil) == SQLITE_OK)
            {
                if sqlite3_step(queryStatement) == SQLITE_DONE
                {
                    print("Record Inserted!")
                    isOK = true
                }
                else
                {
                    print("Fail to Insert")
                }
                sqlite3_finalize(queryStatement)
            }
            else
            {
                print("Insert statement could not be prepared")
            }
            sqlite3_close(db)
        }
        else{
            print("Unable to open database")
        }
        
        return isOK
    }
    
    
    func deleteQuery(shopping:Shopping)->Bool {
        var db:OpaquePointer? = nil
        var isOK = false
        let deleteSQL = "DELETE FROM shoppinglist WHERE itemName = '\(shopping.itemName)'"
        print(deleteSQL)
        
        var queryStatement:OpaquePointer? = nil
        
        
        if sqlite3_open(getDBPath(), &db) ==
            SQLITE_OK{
            print("Successfully opened connection to database")
        
            if (sqlite3_prepare_v2(db, deleteSQL, -1, &queryStatement, nil) == SQLITE_OK)
            {
                if sqlite3_step(queryStatement) == SQLITE_DONE
                {
                    isOK = true
                    print("Record Deleted!")
                }
                else
                {
                    print("Fail to Delete")
                }
                sqlite3_finalize(queryStatement)
            }
            else
            {
                print("Delete statement could not be prepared", terminator: "")
            }
            sqlite3_close(db)
        }
        else
        {
    
            print("Unable to open database",terminator:"" )
        }
        return isOK
    }

    
    
    
    
    func deleteDatabase(){
        let fm = FileManager.default
        
        do{
            try fm.removeItem(atPath: getDBPath())
            print("Database deleted")
        }catch{
            print("Could not delete database")
        }
    }


}

