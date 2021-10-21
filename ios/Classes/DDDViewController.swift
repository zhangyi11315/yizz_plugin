//
//  DDDViewController.swift
//  yizz_plugin
//
//  Created by glory on 2021/9/23.
//

import UIKit
import WebKit
import SDWebImage
import TangramKit

class DDDViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let  rootLayout = TGLinearLayout(.vert)
        rootLayout.tg_size(width: .fill, height: .fill)
        rootLayout.backgroundColor = .red
        self.view.addSubview(rootLayout)
        
        let backButton = UIButton()
        backButton.tg_size(width: .wrap, height: .wrap)
        backButton.setTitle("返回", for: .normal)
        backButton.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        backButton.tg_top.equal(100)
        rootLayout.addSubview(backButton)
        
        // Do any additional setup after loading the view.
    }
    
    @objc func backAction(){
        self.dismiss(animated: true, completion: nil)
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
