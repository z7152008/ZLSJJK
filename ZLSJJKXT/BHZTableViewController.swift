//
//  BHZTableViewController.swift
//  ZLSJJKXT
//
//  Created by 张亮 on 2017/3/5.
//  Copyright © 2017年 zhangliang. All rights reserved.
//

import UIKit
import Alamofire
import  SwiftyJSON
import RappleProgressHUD

class BHZTableViewController: UITableViewController {
    var bhzArr = [bhz]()

    let userDefaults = UserDefaults.standard
    var uname:String?
    var upassword:String?
    //http://221.207.32.74:8880//zljkxt/m/snbhz/scgk.action?staffAccount=sys&staffPass=1
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "水泥拌合站"
        uname = userDefaults.string(forKey: "name")
        upassword = userDefaults.string(forKey: "password")
        getData()
    }
       
    //MARK:获取拌合站数据
    func getData(){
        RappleActivityIndicatorView.startAnimatingWithLabel("数据加载中...", attributes: RappleModernAttributes)
        let url = "http://221.207.32.74:8880//zljkxt/m/snbhz/scgk.action?staffAccount=\(uname!)&staffPass=\(upassword!)"
        print(url)
        Alamofire.request(url).validate().responseJSON { (response) in
            if let value =  response.result.value{
                let json = JSON(value)
                for (_,ObjectValue) in json{
                    let bhzValue = ObjectValue.dictionaryObject! as Dictionary<String,Any>
                    self.bhzArr.append(bhz(bhzDict: bhzValue))
                }
                self.tableView.reloadData()
                RappleActivityIndicatorView.stopAnimating()
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
        return bhzArr.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bhzCell", for: indexPath) as! BHZTableViewCell
        
        //设置背景色
        if (2 + indexPath.row) % 2 == 0{
            
            cell.bhz_mc.backgroundColor = UIColor(displayP3Red: 223/255, green: 223/255, blue: 221/255, alpha: 1)
            cell.bhz_jrcl.backgroundColor = UIColor(displayP3Red: 223/255, green: 223/255, blue: 221/255, alpha: 1)
            cell.bhz_cbpc.backgroundColor = UIColor(displayP3Red: 223/255, green: 223/255, blue: 221/255, alpha: 1)
            cell.bhz_cbcl.backgroundColor = UIColor(displayP3Red: 223/255, green: 223/255, blue: 221/255, alpha: 1)
        }else{
            cell.bhz_mc.backgroundColor = UIColor.clear
            cell.bhz_cbcl.backgroundColor = UIColor.clear
            cell.bhz_cbpc.backgroundColor = UIColor.clear
            cell.bhz_jrcl.backgroundColor = UIColor.clear
        }


        cell.configureCells(bhz: bhzArr[indexPath.row])
        // Configure the cell...

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
        if segue.identifier == "showBhzInfo"{
            let bhzInfoView = segue.destination as! BhzInfoViewController
            let indexPath = tableView.indexPathForSelectedRow
            bhzInfoView.bhz = bhzArr[indexPath!.row]
        }
    }
    

}
