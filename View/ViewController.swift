//文章ページ
//  ViewController.swift
//  ChineseApp

import UIKit

final class MyTableViewController: UITableViewController {
//cellの文章
    var items: [String] = ["sentence1","sentence2","sentence3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

    }

    // MARK: - Table view　設定
    //セクション数の指定
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1    }
    //表示するcellの指定
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    //cellが選択された時の処理
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row)番セルが押されたよ！")
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        cell.accessoryType = .disclosureIndicator // > 表示
        //文字数が多くなった時に改行しなくなるの防止設定
        cell.textLabel?.numberOfLines = 0
        return cell
    }
}
