//
//  MainViewController.swift
//  饮料
//
//  Created by 方瑾 on 2019/2/14.
//  Copyright © 2019 方瑾. All rights reserved.
//
//普通  原价，少冰  一杯-10，不加冰 -20
import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var displayLabel: UILabel!
    @IBOutlet weak var drinksTextField: UITextField!
    @IBOutlet weak var numberTextField: UITextField!
    
    @IBOutlet weak var iceStackView: UIStackView!
    
    @IBOutlet weak var noIceButton: UIButton!
    
    @IBOutlet weak var littleIceButton: UIButton!
    
    @IBOutlet weak var normalIceButton: UIButton!
    @IBOutlet weak var iceLabel: UILabel!
    var drinks : [(name:String,price:Int)] = [("可乐",200),("咖啡",180),("豆浆",100),("红牛",300),("红茶",190)]
    var number = [1,2,3,4,5,6,7,8,9,10]
    var drinksPickerView = UIPickerView()
    var numberPickerView = UIPickerView()
    var total = Int()
    var xiaBiao = Int()
    var numXia = 1
    var coldPrice = Int()
    var hotPrice = Int()
    var isHot = Bool()
    var touch = Int()
    
    
    @IBOutlet weak var smallButton: UIButton!
    
    @IBOutlet weak var normalButton: UIButton!
    
    @IBOutlet weak var bigButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drinksTextField.inputView = drinksPickerView
        drinksPickerView.delegate = self
        drinksPickerView.dataSource = self
        numberTextField.inputView = numberPickerView
        numberPickerView.delegate = self
        numberPickerView.dataSource = self
        coldPrice = drinks[xiaBiao].price
        hotPrice = drinks[xiaBiao].price * 2
        smallButton.backgroundColor = .blue
        normalButton.backgroundColor = .blue
        bigButton.backgroundColor = .blue
        
        
        smallButton.addTarget(self, action: #selector(addColor), for:.touchUpInside )
        normalButton.addTarget(self, action: #selector(addColor), for:.touchUpInside)
        bigButton.addTarget(self, action: #selector(addColor), for:.touchUpInside )
        noIceButton.addTarget(self, action: #selector(addColor), for:.touchUpInside )
        littleIceButton.addTarget(self, action: #selector(addColor), for:.touchUpInside)
        normalIceButton.addTarget(self, action: #selector(addColor), for:.touchUpInside )
        
    }
    @objc func addColor(_ sender:UIButton) {
        switch sender {
        case smallButton:
            smallButton.backgroundColor = .blue
            normalButton.backgroundColor = .gray
            bigButton.backgroundColor = .gray
        case normalButton:
            normalButton.backgroundColor = .blue
            smallButton.backgroundColor = .gray
            bigButton.backgroundColor = .gray
        case bigButton:
            bigButton.backgroundColor = .blue
            smallButton.backgroundColor = .gray
            normalButton.backgroundColor = .gray
        case noIceButton:
            noIceButton.backgroundColor = .blue
            littleIceButton.backgroundColor = .gray
            normalIceButton.backgroundColor = .gray
        case littleIceButton:
            littleIceButton.backgroundColor = .blue
            noIceButton.backgroundColor = .gray
            normalIceButton.backgroundColor = .gray
        case normalIceButton:
            normalIceButton.backgroundColor = .blue
            noIceButton.backgroundColor = .gray
            littleIceButton.backgroundColor = .gray
        default:
            break
        }
        touch = sender.tag
        totalPrice()
        
    }
    func totalPrice()  {
        if !isHot {
            if touch == 0 {
                coldPrice = drinks[xiaBiao].price
            } else if touch == 1 {
                coldPrice = drinks[xiaBiao].price * 2
            } else if touch == 2 {
                coldPrice = drinks[xiaBiao].price * 3
            }
            total = number[numXia-1] * coldPrice
            if touch == 3 {
                total = total - 20
            } else if touch == 4 {
                total = total - 10
            } else if touch == 5 {
                total = number[numXia-1] * coldPrice
            }
            
        } else {
            if touch == 0 {
                hotPrice = drinks[xiaBiao].price * 2
            } else if touch == 1 {
                hotPrice = drinks[xiaBiao].price * 3
            } else {
                hotPrice = 0
            }
            total = number[numXia-1] * hotPrice
        }
        if numXia != 0 {
            if hotPrice != 0 {
                displayLabel.text = "\(drinks[xiaBiao].name)共\(numXia)瓶，总消费\(total)円"
            } else {
                displayLabel.text = "无热饮大杯服务"
            }
            
        }
        
    }
    
    @IBAction func isOnSwitch(_ sender: UISwitch) {
        if drinksTextField.text != "可乐" && drinksTextField.text != "红牛" {
//            sender.isEnabled = true //开关无法使用
            isHot = sender.isOn
            if !sender.isOn {
                bigButton.isHidden = false
                smallButton.backgroundColor = .blue
                normalButton .backgroundColor = .gray
                bigButton.backgroundColor = .gray
                iceStackView.isHidden = false
                littleIceButton.backgroundColor = .blue
                noIceButton.backgroundColor = .gray
                normalIceButton.backgroundColor = .gray
                iceLabel.isHidden = false
                totalPrice()
                if touch == 0 {
                    coldPrice = drinks[xiaBiao].price
                } else if touch == 1 {
                    coldPrice = drinks[xiaBiao].price * 2
                } else if touch == 2 {
                    coldPrice = drinks[xiaBiao].price * 3
                }
                
            } else {
                bigButton.isHidden = true
                iceStackView.isHidden = true
                iceLabel.isHidden = true
                totalPrice()
                if touch == 0 {
                    hotPrice = drinks[xiaBiao].price * 2
                } else if touch == 1 {
                    hotPrice = drinks[xiaBiao].price * 3
                } else if touch == 2 {
                    hotPrice = 0
                }
            }
        } else {
            sender.isOn = false
            if touch == 0 {
                coldPrice = drinks[xiaBiao].price
            } else if touch == 1 {
                coldPrice = drinks[xiaBiao].price * 2
            } else if touch == 2 {
                coldPrice = drinks[xiaBiao].price * 3
            }
        }
       
    }
}


extension MainViewController : UIPickerViewDelegate,UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == drinksPickerView {
            return drinks.count
        } else {
            return number.count
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == drinksPickerView {
            return drinks[row].name
        } else {
            return String(number[row])
        }
        
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == drinksPickerView {
            drinksTextField.text = drinks[row].name
            coldPrice = drinks[row].price
            hotPrice = drinks[row].price * 2
            xiaBiao = row
        } else {
            numberTextField.text = String(number[row])
            numXia = row + 1
        }
        totalPrice()
        
    }
    
}
//isHidden  隐藏
