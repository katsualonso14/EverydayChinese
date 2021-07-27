//  Created by 玉井　勝也 on 2021/07/25.

import UIKit
import SnapKit

class BiginnerViewController: UITableViewController {
    
    let titleName: String

       init(titleName: String) {
           self.titleName = titleName
           super.init(nibName: nil, bundle: nil)
       }

       required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

       private lazy var container: UIView = {
           let container = UIView()
           container.backgroundColor = UIColor.white
           return container
       }()

       override func viewDidLoad() {
           super.viewDidLoad()
           navigationItem.title = titleName
           self.view.addSubview(container)
           container.snp.makeConstraints { make in
               make.edges.equalToSuperview()
           }
       }

       override func didReceiveMemoryWarning() {
           super.didReceiveMemoryWarning()
           // Dispose of any resources that can be recreated.
       }
}
