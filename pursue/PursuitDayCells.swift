//
//  PursuitDayCells.swift
//  pursue
//
//  Created by Jaylen Sanders on 7/2/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class PursuitDayCells : UICollectionViewCell {
    
    
    let postTableView : UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .none
        return tableView
    }()

    
    func setupView(){
        addSubview(postTableView)
        postTableView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: self.frame.size.width, height: 480)
        postTableView.delegate = self
        postTableView.dataSource = self
        postTableView.register(PursuitDayTableViewCell.self, forCellReuseIdentifier: "Cell")
        postTableView.reloadData()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension PursuitDayCells : UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! PursuitDayTableViewCell
        cell.setupView(index: indexPath.row)
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
}
