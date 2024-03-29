//
//  HomeViewController.swift
//  HW3
//
//  Created by 김민섭 on 2023/09/30.
//

import UIKit

class FirstViewController: UIViewController {
    
    let sectionTitles : [String] = ["Continue Watching for Eron","My List","Europe movie","Romance/Drama","Action/Thriller"]
    
    private let homeFeedTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(homeFeedTable)
        
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
        
        configureNavbar()
        
        let headerView = MediaViewController(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 450))
        homeFeedTable.tableHeaderView = headerView
    }
    
    private func configureNavbar(){
        var image = UIImage(named: "netflix")
        image = image?.withRenderingMode(.alwaysOriginal)
        let netflix = UIBarButtonItem(image: image, style: .done, target: self, action: nil)
        
        let item1 = UIBarButtonItem(title: "TV Shows", style: .plain, target: self, action: #selector(ButtonPressed))
        
        let item2 = UIBarButtonItem(title: "Movie", style: .plain, target: self, action: #selector(ButtonPressed))

        let item3 = UIBarButtonItem(title: "My List", style: .plain, target: self, action: #selector(ButtonPressed))
        
        item1.tintColor = UIColor.white
        item2.tintColor = UIColor.white
        item3.tintColor = UIColor.white
        navigationItem.leftBarButtonItems = [netflix, item1, item2, item3]
    }
    
    @objc private func ButtonPressed(){
        //비어있음
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTable.frame = view.bounds
    }

}

extension FirstViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 1
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {//to stick the navigationbar to the top
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset

        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0,-offset))
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else{
            return UITableViewCell()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        return 40
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?{
        return sectionTitles[section]
    }

}
