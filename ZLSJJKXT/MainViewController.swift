//
//  MainViewController.swift
//  ZLSJJKXT
//
//  Created by 张亮 on 2017/3/1.
//  Copyright © 2017年 zhangliang. All rights reserved.
//

import UIKit

class MainViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var btnTitle: UIButton!
        var arr:[[String]] = [["1.png","水泥拌合站"],["2.png","标准养护室"],["3.png","压力机"],["4.png","万能机"],["5.png","沥青拌合站"],["6.png","水稳定合站"],["7.png","压浆设备"],["8.png","张拉设备"],["9.png","路面摊铺"]]

    let attributedString = NSMutableAttributedString(string: "")
    let attrs :[String:Any] = [
        NSFontAttributeName:UIFont.systemFont(ofSize: 15.0),
        NSForegroundColorAttributeName:UIColor.white,
        NSUnderlineStyleAttributeName:1
    ]
    
    let userDefaults = UserDefaults.standard
    
    
    @IBAction func loginOut(_ sender: UIButton) {
        let outView = self.storyboard?.instantiateViewController(withIdentifier: "s_loginout")
        
        self.present(outView!, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        let uname = userDefaults.string(forKey: "name")
        let btnLabel = "当前版本v1.0 切换当前用户\(uname!)"
        
        let gString = NSMutableAttributedString(string: btnLabel, attributes: attrs)
        attributedString.append(gString)
        btnTitle.setAttributedTitle(attributedString, for: .normal)
        
        collectionView.backgroundColor = .clear
        
        self.collectionView.register(UINib(nibName: "MainCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! MainCollectionViewCell
        var index = arr[indexPath.row]
        cell.imageView.image = UIImage(named: index[0])
        cell.label.text = index[1]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row{
        case 0:
        
            let view = self.storyboard?.instantiateViewController(withIdentifier: "s_snbhz")
            self.navigationController?.pushViewController(view!, animated: true)
            
        case 1:
            let view = self.storyboard?.instantiateViewController(withIdentifier: "s_bys")
            self.navigationController?.pushViewController(view!, animated: true)
        case 2:
            let view = self.storyboard?.instantiateViewController(withIdentifier: "s_ylj")
            self.navigationController?.pushViewController(view!, animated: true)
        case 3:
            let view = self.storyboard?.instantiateViewController(withIdentifier: "s_wnj")
            self.navigationController?.pushViewController(view!, animated: true)
        default:
        let label = UILabel(frame: CGRect(x:(self.view.frame.width - 100)/2, y: self.view.frame.height - 100, width: 100, height: 20))
            label.text = "功能建设中..."
            label.font = UIFont.systemFont(ofSize: 15)
            label.layer.cornerRadius = 5
            label.layer.masksToBounds = true
            label.textAlignment = .center
            label.textColor =  .white
            label.backgroundColor = .black
            self.view.addSubview(label)
            UIView.animate(withDuration: 2.0, animations: { 
                label.alpha = 0
            }, completion: { (_) in
                label.removeFromSuperview()
            })
        }
    }
}

