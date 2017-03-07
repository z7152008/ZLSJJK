//
//  YLJTableViewController.swift
//  ZLSJJKXT
//
//  Created by 张亮 on 2017/3/5.
//  Copyright © 2017年 zhangliang. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import RappleProgressHUD

class YLJTableViewController: UITableViewController {
    
    var yljArr:[ylj] = [ylj]()
    var uname:String?
    var upassword:String?
    
    let userDefaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()

        uname = userDefaults.string(forKey: "name")
        upassword = userDefaults.string(forKey: "password")
        self.navigationItem.title = "压力机"
        getData()
    }
    
    
    func getData(){
        RappleActivityIndicatorView.startAnimatingWithLabel("数据加载中...", attributes: RappleModernAttributes)
        let url = "http://221.207.32.74:8880//zljkxt/m/ylj/sygk.action?staffAccount=\(uname!)&staffPass=\(upassword!)"
        Alamofire.request(url).responseJSON { (response) in
            switch response.result{
            case .success:
                if let value = response.result.value{
                    let json =  JSON(value)
                    for (_,objecValue) in json{
                      let yljvalue = objecValue.dictionaryObject! as Dictionary<String,Any>
                        self.yljArr.append(ylj(yljDic: yljvalue))
                    }
                    self.tableView.reloadData()
                    RappleActivityIndicatorView.stopAnimating()
                }
                
                break
                
            case .failure(let error):
                RappleActivityIndicatorView.stopAnimating()
                print(error)
                break
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return yljArr.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "yljCell", for: indexPath) as! YLJTableViewCell
        
        //设置背景色
        if (2 + indexPath.row) % 2 == 0{
            
            cell.ylj_mc.backgroundColor = UIColor(displayP3Red: 223/255, green: 223/255, blue: 221/255, alpha: 1)
            cell.ylj_qddbz?.backgroundColor = UIColor(displayP3Red: 223/255, green: 223/255, blue: 221/255, alpha: 1)
            cell.ylj_sylx.backgroundColor = UIColor(displayP3Red: 223/255, green: 223/255, blue: 221/255, alpha: 1)
            cell.ylj_sysj.backgroundColor = UIColor(displayP3Red: 223/255, green: 223/255, blue: 221/255, alpha: 1)
        }else{
            cell.ylj_mc.backgroundColor = UIColor.clear
            cell.ylj_qddbz?.backgroundColor = UIColor.clear
            cell.ylj_sylx.backgroundColor = UIColor.clear
            cell.ylj_sysj.backgroundColor = UIColor.clear
        }


        // Configure the cell...
        let index = indexPath.row
        cell.configureCells(ylj: yljArr[index])

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "showYljInfo"{
            let yljInfoview = segue.destination as! YljInfoViewController
            let index = tableView.indexPathForSelectedRow
            yljInfoview.ylj = yljArr[index!.row]
        }
    }
    

}
