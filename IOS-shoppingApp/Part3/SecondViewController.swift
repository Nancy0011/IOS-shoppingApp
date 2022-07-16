//
//  SecondViewController.swift
//  Part3
//
//  Created by Jinghua Zhong on 2/11/21.
//

import UIKit
import SQLite3

class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var shoppingTableView: UITableView!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var db:OpaquePointer? = nil
    
    @IBOutlet weak var shoppingTable: UITableView!
    
    func selectQuery() {
        let selectQueryStatement = "SELECT * FROM shoppinglist"
        var queryStatement: OpaquePointer? = nil
       
        if sqlite3_open(appDelegate.getDBPath(), &db) ==
            SQLITE_OK{
            print("Successfully opened connection to database")
        
            if (sqlite3_prepare_v2(db, selectQueryStatement, -1, &queryStatement, nil) == SQLITE_OK)
            {
                print("Query Result: ")
                while (sqlite3_step(queryStatement) == SQLITE_ROW)
                {
                    let itemKey = Int( sqlite3_column_int(queryStatement, 0))
                    let itemField = sqlite3_column_text(queryStatement,1)
                    let itemName = String(cString: itemField!)
                    let itemPrice = Double(sqlite3_column_double(queryStatement,2))
                    let typeField = sqlite3_column_text(queryStatement,3)
                    let itemType = String(cString: typeField!)
                    let itemQuantity = Int(sqlite3_column_int(queryStatement,4))
                    
                    print("\(itemPrice)|\(itemName)")
                    let s = Shopping(itemKey: itemKey, itemName: itemName, itemPrice: itemPrice, itemType: itemType, quantity: itemQuantity)
                    appDelegate.ShoppingArray.append(s)
                }
            }
            else
            {
              print("SELECT statement could not be prepared")
            }
    
            sqlite3_finalize(queryStatement)
            sqlite3_close(db)
        }
}
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView (_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appDelegate.ShoppingArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath as IndexPath)
        
        let shopping:Shopping = appDelegate.ShoppingArray[indexPath.row]
        cell.textLabel!.text = shopping.itemName
        //cell.detailTextLabel!.text=shopping.toString()
        return cell
        
    }
    
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        shoppingTable.reloadData()
        self.view.backgroundColor = Colour.sharedInstance.selectedColour
        }
       
    
    
//    func deleteQuery(itemName:String) {
//
//        let deleteSQL = "DELETE FROM shoppinglist WHERE item = ('\(itemName)')"
//        print(deleteSQL)
//
//        var queryStatement:OpaquePointer? = nil
//
//
//        if sqlite3_open(appDelegate.getDBPath(), &db) ==
//            SQLITE_OK{
//            print("Successfully opened connection to database")
//
//            if (sqlite3_prepare_v2(db, deleteSQL, -1, &queryStatement, nil) == SQLITE_OK)
//            {
//                if sqlite3_step(queryStatement) == SQLITE_DONE
//                {
//
//                    print("Record Deleted!")
//                }
//                else
//                {
//                    print("Fail to Delete")
//                }
//                sqlite3_finalize(queryStatement)
//            }
//            else
//            {
//                print("Delete statement could not be prepared", terminator: "")
//            }
//            sqlite3_close(db)
//        }
//        else
//        {
//
//            print("Unable to open database",terminator:"" )
//        }
//    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCell.EditingStyle.delete) {
            //Delete from DB
            let selectedItem: Shopping = appDelegate.ShoppingArray[indexPath.row]
//            let itemName:String = selectedItem.itemName
            if (appDelegate.deleteQuery(shopping: selectedItem)){
                //Remove from the arrray and the table
                appDelegate.ShoppingArray.remove(at:indexPath.row)
                tableView.deleteRows(at:[indexPath],with:.fade)
            }
            
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectQuery()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
