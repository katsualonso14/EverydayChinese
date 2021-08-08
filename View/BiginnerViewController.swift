//  Created by 玉井　勝也 on 2021/07/25.

import UIKit
import SnapKit

class BiginnerViewController: UITableViewController {
    
    let titleName: String
    var sentence = ["aaa","bbb","ccc"]
    
    init(titleName: String) {
        self.titleName = titleName
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    //　　　　viewのセット
    private lazy var container: UIView = {
        let container = UIView()
        container.backgroundColor = UIColor.white
        return container
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        タイトル
        navigationItem.title = titleName
        self.view.addSubview(container)
        
        container.snp.makeConstraints { make in
            make.edges.equalToSuperview() //中心点を親Viewと合わせる
        }
        tableView.dataSource = self
        tableView.delegate  = self
        //regisiterを入れないと画面遷移しないs
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

       override func didReceiveMemoryWarning() {
           super.didReceiveMemoryWarning()
           // Dispose of any resources that can be recreated.
       }
    //cellの数
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sentence.count
    }
    //cellの中身
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            
            cell.textLabel?.text = sentence[indexPath.row]
            return cell
        }
    //cellをタップした時の処理
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected")
        
    }
    
    
}
