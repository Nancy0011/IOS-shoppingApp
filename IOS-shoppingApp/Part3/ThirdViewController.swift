//
//  ThirdViewController.swift
//  Part3
//
//  Created by Jinghua Zhong on 3/11/21.
//

import UIKit

class ThirdViewController: FirstViewController {

    @available(ios 14.0, *)
    let colorArray = [ 0x000000, 0xfe0000, 0xff7900, 0xffb900, 0xffde00, 0xfcff00, 0xd2ff00, 0x05c000, 0x00c0a7, 0x0600ff, 0x6700bf, 0x9500c0, 0xbf0199, 0xffffff ]
    
    @IBOutlet weak var selectedColourView: UIImageView!
    
    @IBOutlet weak var slider: UISlider!
    
    func uiColorFromHex(rgbValue: Int) ->UIColor{
        
    let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 0xFF
    let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 0xFF
    let blue = CGFloat(rgbValue & 0x0000FF) / 0xFF
    let alpha = CGFloat(1.0)

    return UIColor(red:red,green:green,blue:blue,alpha:alpha)
    }
    @IBAction func changeClicked(_ sender: UIButton) {

        
        let picker = UIColorPickerViewController()
        // Setting the Initial Color of the Picker
        picker.selectedColor = self.view.backgroundColor!
        
        // Setting Delegate
        picker.delegate = self
        
        // Presenting the Color Picker
        self.present(picker, animated: true, completion:nil)
        
        
        
        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

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
    @available(ios 14.0, *)
    extension ThirdViewController:UIColorPickerViewControllerDelegate {
        // Called once you have finished picking the color.

        func colorPickerViewControllerDidFinish(_ viewController:
                                                    UIColorPickerViewController) {
            self.view.backgroundColor = viewController.selectedColor
        }
        // Called on every color selection done in the picker.
        func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
            self.view.backgroundColor = viewController.selectedColor
            Colour.sharedInstance.selectedColour = self.view.backgroundColor
        }
    }


