
import UIKit

protocol ExploreCategoryDelegate {
    func exploreCategoryTapped()
}

class ExploreCategoryRow : UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, CategoryDetailDelegate {
    
    var exploreDelegate : ExploreCategoryDelegate?
    
    func changeToDetail(for cell: ExploreCategoryCells) {
        exploreDelegate?.exploreCategoryTapped()
    }
    
    
    let rowLabel : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.text = "INTERESTS"
        return label
    }()
    
    let cellId = "cellId"
    let peopleId = "peopleId"
    
    let postCollection : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ((frame.width - 2) / 5) + 20, height: ((frame.width - 2) / 6) - 25)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ExploreCategoryCells
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 12, 0, 12)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(postCollection)
        addSubview(rowLabel)
        
        rowLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: rowLabel.intrinsicContentSize.width, height: rowLabel.intrinsicContentSize.height)
        postCollection.anchor(top: rowLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        postCollection.showsHorizontalScrollIndicator = false
        postCollection.register(ExploreCategoryCells.self, forCellWithReuseIdentifier: cellId)
        postCollection.dataSource = self
        postCollection.delegate = self
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

