//
//  YljInfoViewController.swift
//  ZLSJJKXT
//
//  Created by 张亮 on 2017/3/5.
//  Copyright © 2017年 zhangliang. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import RappleProgressHUD

class YljInfoViewController: UIViewController {
    var ylj:ylj?
    
    var currentRownum:Int = 1
    let userDefaults = UserDefaults.standard
 
    @IBOutlet weak var sysj: UILabel!
    @IBOutlet weak var ypbh: UILabel!
    @IBOutlet weak var sylx: UILabel!
    @IBOutlet weak var sjqd: UILabel!
    @IBOutlet weak var cymj: UILabel!
    @IBOutlet weak var lq: UILabel!
    @IBOutlet weak var hz1: UILabel!
    @IBOutlet weak var hz2: UILabel!
    @IBOutlet weak var hz3: UILabel!
    @IBOutlet weak var hz4: UILabel!
    @IBOutlet weak var hz5: UILabel!
    @IBOutlet weak var hz6: UILabel!
    @IBOutlet weak var hzdbz: UILabel!
    @IBOutlet weak var qddbz: UILabel!
    @IBOutlet weak var zt: UILabel!
    @IBOutlet weak var gcbw: UILabel!
    @IBOutlet weak var bz: UILabel!
    @IBOutlet weak var cjsj: UILabel!
    
    
    //http://221.207.32.74:8880//zljkxt/m/ylj/sysj.action?rownum=1&sbid=2ae10f7a4dd94bd590607d18a5de2bce
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = ylj?.ylj_mc
        getData(1)

        // Do any additional setup after loading the view.
    }
    
    func getData(_ rownum:Int){
        
        RappleActivityIndicatorView.startAnimatingWithLabel("加载数据中...", attributes: RappleModernAttributes)
        let url = "http://221.207.32.74:8880//zljkxt/m/ylj/sysj.action?rownum=\(rownum)&sbid=\(ylj!.ylj_id)"
        userDefaults.set(rownum, forKey: "yljrownum")
        Alamofire.request(url).responseJSON { (response) in
            switch response.result{
            case .success:
                if let value = response.result.value{
                    let json = JSON(value)
                   
                    self.sysj.text = json["sysj"].stringValue
                    self.ypbh.text = json["yphb"].stringValue
                    self.sylx.text = json["sylx"].stringValue
                    self.sjqd.text = json["qddj"].stringValue
                    self.cymj.text = json["cymj"].stringValue
                    self.lq.text = json["lingqi"].stringValue
                    self.hz1.text = "\(json["hz1"].doubleValue)"
                     self.hz2.text = "\(json["hz2"].doubleValue)"
                     self.hz3.text = "\(json["hz3"].doubleValue)"
                     self.hz4.text = "\(json["hz4"].doubleValue)"
                     self.hz5.text = "\(json["hz5"].doubleValue)"
                     self.hz6.text = "\(json["hz6"].doubleValue)"
                    self.hzdbz.text = "\(json["hzdbz"].doubleValue)"
                    self.qddbz.text = "\(json["qddbz"].doubleValue)"
                    self.zt.text = json["zhuangtai"].stringValue
                    self.gcbw.text = json["gcbw"].stringValue
                    self.bz.text = json["beizhu"].stringValue
                    self.cjsj.text = json["cjsj"].stringValue
                    
                }
                RappleActivityIndicatorView.stopAnimating()
                break
            case .failure(let error):
                self.sysj.text = "-"
                self.ypbh.text = "-"
                self.sylx.text = "-"
                self.sjqd.text = "-"
                self.cymj.text = "-"
                self.lq.text = "-"
                self.hz1.text = "-"
                self.hz2.text = "-"
                self.hz3.text = "-"
                self.hz4.text = "-"
                self.hz5.text = "-"
                self.hz6.text = "-"
                self.hzdbz.text = "-"
                self.qddbz.text = "-"
                self.zt.text = "-"
                self.gcbw.text = "-"
                self.bz.text = "-"
                self.cjsj.text = "-"

                
                RappleActivityIndicatorView.stopAnimating()
                print(error)
                break
            }
        }
        
    }

    

    @IBAction func previousPage(_ sender: UIButton) {
        currentRownum = userDefaults.integer(forKey: "yljrownum")
        if currentRownum <= 1{
            print("第一页")
        }else{
            
            getData(currentRownum - 1)
        }

    }
    @IBAction func nextPage(_ sender: UIButton) {
        currentRownum = userDefaults.integer(forKey: "yljrownum")
        getData(currentRownum + 1)
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
