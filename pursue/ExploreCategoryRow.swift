
import UIKit
import Alamofire

protocol ExploreCategoryDelegate {
    func exploreCategoryTapped()
}

class ExploreCategoryRow : UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    var exploreDelegate : ExploreCategoryDelegate?
    var accessExploreController : ExploreController?
    
    lazy var searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.placeholder = "Search..."
        sb.searchBarStyle = UISearchBarStyle.prominent
        sb.backgroundImage = UIImage(color: .clear)
        sb.delegate = self
        sb.barTintColor = .white
        sb.isTranslucent = true
        
        let attributedPlaceholder = NSMutableAttributedString(string: "Search", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 24), NSAttributedStringKey(rawValue: NSAttributedStringKey.foregroundColor.rawValue): UIColor.gray])
        
        let textFieldPlaceHolder = sb.value(forKey: "searchField") as? UITextField
        textFieldPlaceHolder?.attributedPlaceholder = attributedPlaceholder
        
        return sb
    }()
    
    var users = [User]()
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        guard let searchText = searchBar.text else { return }
        getSearchContent(searchText: searchText)
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            print("Search is empty")
        } else {
            print(searchText)
            getSearchContent(searchText: searchText)
        }
    }
    
    func getSearchContent(searchText : String){
        let url = "https://pursuit-jaylenhu27.c9users.io/search"
        var parameters = Alamofire.Parameters()
        parameters["searchField"] = searchText
        
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
            switch response.result {
            case .success:
                guard let dictionaries = response.result.value as? [Dictionary<String,AnyObject>] else { return }
                for dictionary in dictionaries {
                    print(dictionary)
                    let user = User(dictionary: dictionary)
                    self.users.append(user)
                    print(self.users)
                    //                        var interest = Interests(dictionary: dictionary)
                    //                        if let value = dictionary["SelectedInterests"] as? Int, value == 1 {
                    //                            interest.isSelected = true
                    //                        } else {
                    //                            interest.isSelected = false
                    //                        }
                    //                        self.interests.append(interest)
                    //                        self.interestsCollection.reloadData()
                }
            case .failure:
                print("Failure: \(response.result.isSuccess)")
            }
            
        }
    }
 
    let cellId = "cellId"
    let peopleId = "peopleId"
    let interestsNames = ["Trending", "Animals", "Art", "Business", "Cars", "Design", "Finance", "Fashion", "Food", "Health", "Home", "Math", "Music", "Self", "Science", "Sports", "Tech", "Writing"]
    
    let postCollection : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 18
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        accessExploreController?.scrollToMenuIndex(menuIndex: indexPath.item)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let approximateWidthOfCell = frame.width
        let size = CGSize(width: approximateWidthOfCell, height: .infinity)
        let attributes = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 18)]
        let estimatedFrame = NSString(string: interestsNames[indexPath.item]).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        return CGSize(width: estimatedFrame.width + 12, height: ((frame.width - 2) / 6) - 5)        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ExploreCategoryCells
        cell.selectInterests.text = interestsNames[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 12, 0, 12)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(searchBar)
        addSubview(postCollection)
        
        searchBar.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 0, height: searchBar.intrinsicContentSize.height)
        postCollection.anchor(top: searchBar.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 60)
        
        postCollection.showsHorizontalScrollIndicator = false
        postCollection.register(ExploreCategoryCells.self, forCellWithReuseIdentifier: cellId)
        postCollection.dataSource = self
        postCollection.delegate = self
        
        let selectedIndexPath = IndexPath(item: 0, section: 0)
        postCollection.selectItem(at: selectedIndexPath, animated: false, scrollPosition: [])
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

