//
//  Shopping.swift
//  Part3
//
//  Created by z on 2/11/21.
//

import Foundation
public class Shopping {
    public var itemKey: Int
    public var itemName:String
    public var itemPrice:Double
    public var itemType:String
    public var quantity:Int
    
    //default
    public init() {
        self.itemKey = 0
        self.itemName = ""
        self.itemPrice = 0
        self.itemType = ""
        self.quantity = 0
    }
    
    public init(itemKey:Int, itemName:String,itemPrice: Double, itemType:String, quantity:Int) {
        self.itemKey = itemKey
        self.itemName = itemName
        self.itemPrice = itemPrice
        self.itemType = itemType
        self.quantity = quantity
        
    }
    
    public func toString() ->String
    {
        
        return "ItemKey : " + String(format: "%d",self.itemKey) + "Item Name : " + self.itemName + "Item Price : " + String(format:"0.2f", self.itemPrice) + "Item Type : " + self.itemType + "Quantity: " + String(format:"%d",self.quantity)
    }
}


     
