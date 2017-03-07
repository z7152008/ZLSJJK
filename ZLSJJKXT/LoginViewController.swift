//
//  LoginViewController.swift
//  ZLSJJKXT
//
//  Created by 张亮 on 2017/3/2.
//  Copyright © 2017年 zhangliang. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class LoginViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet var loginView: UIView!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var uname: UITextField!
    @IBOutlet weak var upassword: UITextField!
    
    let userDefaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()

        uname.tag = 0
        upassword.tag = 1
        
        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.returnKeyType != .done{
            let nextTag = textField.tag + 1
            let nextTextField = self.view.viewWithTag(nextTag)
            nextTextField?.becomeFirstResponder()
        }else if textField.returnKeyType == .done{
            btnLogin(loginBtn)
        }else{
            textField.becomeFirstResponder()
        }
        return true
    }

    override func didReceiveMemoryWarning() {
       
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnLogin(_ sender: UIButton) {
        upassword.resignFirstResponder()
        let url = "http://221.207.32.74:8880/zljkxt/m/mlogin.action?staffAccount=\(uname.text!)&staffPass=\(upassword.text!)"
        Alamofire.request(url).validate().responseJSON { (response) in
            switch response.result{
            case .success:
                if let value = response.result.value{
                    let json = JSON(value)
                    let flag = json["flag"].bool
                    let msg = json["message"].string
                    if flag!{
                        self.performSegue(withIdentifier: "s_login", sender: self)
                        self.userDefaults.set("\(self.uname.text!)", forKey: "name")
                        self.userDefaults.set("\(self.upassword.text!)", forKey: "password")
                    }else{
                        let label = UILabel(frame: CGRect(x:(self.loginView.frame.width - 130)/2 , y: 90, width: 120, height: 20))
                        label.text = msg!
                        label.font = UIFont.systemFont(ofSize: 15)
                        label.textColor = .white
                        label.backgroundColor = .black
                        label.layer.cornerRadius = 5
                        label.layer.masksToBounds = true
                        label.textAlignment = .center
                        self.loginView.addSubview(label)
                        UIView.animate(withDuration: 3.0, animations: { 
                            label.alpha = 0.0
                        }, completion: { (_) in
                            label.removeFromSuperview()
                        })
                    }
                }
            case .failure(let error):
                let label = UILabel(frame: CGRect(x:(self.loginView.frame.width - 130)/2 , y: 100, width: 130, height: 20))
                label.text = "\(error)"
                label.font = UIFont.systemFont(ofSize: 15)
                label.textColor = .white
                label.backgroundColor = .black
                label.layer.cornerRadius = 5
                label.layer.masksToBounds = true
                label.textAlignment = .center
                self.loginView.addSubview(label)
                UIView.animate(withDuration: 3.0, animations: {
                    label.alpha = 0.0
                }, completion: { (_) in
                    label.removeFromSuperview()
                })

            }
        }
    }
}
