//
//  WnjInfoViewController.swift
//  ZLSJJKXT
//
//  Created by 张亮 on 2017/3/5.
//  Copyright © 2017年 zhangliang. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import RappleProgressHUD

class WnjInfoViewController: UIViewController {
    var wnjArr:[Any] = [Any]()
    var wnj:wnj?
    var wnj_id:String?
    var currentRownum:Int = 1
    let userDefaults = UserDefaults.standard
    
    @IBOutlet weak var sysj: UILabel!
    @IBOutlet weak var syry: UILabel!
    @IBOutlet weak var cjsj: UILabel!
    @IBOutlet weak var ypbh: UILabel!
    @IBOutlet weak var sylx: UILabel!
    @IBOutlet weak var gczj: UILabel!
    @IBOutlet weak var zdhz: UILabel!
    @IBOutlet weak var klqd: UILabel!
    @IBOutlet weak var sqfl: UILabel!
    @IBOutlet weak var sqfqd: UILabel!
    @IBOutlet weak var xqfl: UILabel!
    @IBOutlet weak var xqfqd: UILabel!
    
    @IBOutlet weak var zt: UILabel!
    @IBOutlet weak var gcbw: UILabel!
    @IBOutlet weak var bz: UILabel!
    
    //http://221.207.32.74:8880//zljkxt/m/wnj/sysj.action?rownum=1&sbid=35959e5b898646cca0fc544ab8211f7c
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = wnj?.wnj_mc
        wnj_id = wnj?.wnj_id
        getData(1)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func previousPage(_ sender: UIButton) {
        currentRownum = userDefaults.integer(forKey: "wnjrownum")
        if currentRownum <= 1{
            print("第一页")
        }else{
            getData(currentRownum - 1)
        }
    }
    @IBAction func nextPage(_ sender: UIButton) {
        currentRownum = userDefaults.integer(forKey: "wnjrownum")
        getData(currentRownum + 1)
    }
    
    func getData(_ rownum:Int){
        self.wnjArr.removeAll()
        RappleActivityIndicatorView.startAnimatingWithLabel("加载数据中...", attributes: RappleModernAttributes)
        let url = "http://221.207.32.74:8880//zljkxt/m/wnj/sysj.action?rownum=\(rownum)&sbid=\(wnj_id!)"
        userDefaults.set(rownum, forKey: "wnjrownum")
        Alamofire.request(url).responseJSON { (response) in
            switch response.result{
            case .success:
                if let value = response.result.value{
                    let json = JSON(value)
                    print(json)
                    self.sysj.text = json["sysj"].stringValue
                    self.syry.text = json["syry"].stringValue
                    self.bz.text = json["beizhu"].stringValue
                    self.sylx.text = json["sylx"].stringValue
                    self.xqfqd.text = "\(json["xqfqd"].doubleValue)"
                    self.gcbw.text = json["gcbw"].stringValue
                    self.klqd.text = "\(json["klqd"].doubleValue)"
                    self.sqfl.text = "\(json["sqfl"].doubleValue)"
                    self.xqfl.text = "\(json["xqfl"].doubleValue)"
                    self.zdhz.text = "\(json["zdl"].doubleValue)"
                    self.cjsj.text = json["cjsj"].stringValue
                    self.sqfqd.text = "\(json["sqfqd"].doubleValue)"
                    self.gczj.text = "\(json["zhijing"].doubleValue)"
                    self.zt.text = json["zhuangtai"].stringValue
                    self.ypbh.text = json["ypbh"].stringValue
                    
                }
                RappleActivityIndicatorView.stopAnimating()
                break
            case .failure(let error):
                self.sysj.text = "-"
                self.syry.text = "-"
                self.bz.text = "-"
                self.sylx.text = "-"
                self.xqfqd.text = "-"
                self.gcbw.text = "-"
                self.klqd.text = "-"
                self.sqfl.text = "-"
                self.xqfl.text = "-"
                self.zdhz.text = "-"
                self.cjsj.text = "-"
                self.sqfqd.text = "-"
                self.gczj.text = "-"
                self.zt.text = "-"
                self.ypbh.text = "-"

                RappleActivityIndicatorView.stopAnimating()
                print(error)
                break
            }
        }
    
    }
    

    
}
