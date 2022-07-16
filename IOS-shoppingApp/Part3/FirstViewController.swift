//
//  FirstViewController.swift
//  Part3
//
//  Created by Jinghua Zhong on 2/11/21.
//

import UIKit
import SQLite3

class FirstViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var db:OpaquePointer? = nil
    var typeArray:[String] = ["Grocery", "Tech", "Books", "Clothing","Toys", "Other"]
    
    

    @IBOutlet weak var itemNameTextField: UITextField!
    
    @IBOutlet weak var priceTextField: UITextField!
    
    @IBOutlet weak var qtyTextFiled: UITextField!
    
    @IBOutlet weak var statusLabel: UILabel!
    
    
    @IBAction func addClicked(_ sender: UIButton) {
        

        var itemName:String?
        var itemPrice:Double?
        var itemType:String?
        var quantity:Int?
       
        itemName = itemNameTextField.text!
        itemPrice = NSString(string:priceTextField.text!).doubleValue
        itemType = typeArray[typePickerView.selectedRow(inComponent: 0)]
        quantity = NSString(string:qtyTextFiled.text!).integerValue
        
        print(itemType!)
        
        let s = Shopping(itemKey: 0, itemName:itemName!,itemPrice:itemPrice!,itemType:itemType!,quantity:quantity!)
    
        if(appDelegate.insertQuery(shopping: s) == true){
            statusLabel.text = "Record Inserted!"
            itemNameTextField.text = ""
            priceTextField.text = ""
            qtyTextFiled.text = ""
            appDelegate.ShoppingArray.append(s)
        }
    }
    @IBOutlet weak var typePickerView: UIPickerView!
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return typeArray.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return typeArray[row] as String
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.view.backgroundColor =
            Colour.sharedInstance.selectedColour
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
