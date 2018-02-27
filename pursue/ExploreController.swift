//
//  ExploreContainer.swift
//  pursue
//
//  Created by Jaylen Sanders on 11/27/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit
import XLActionController
import Alamofire

class ExploreController : UICollectionViewController, UICollectionViewDelegateFlowLayout, ExploreExerciseDelegate, ExplorePrincipleDelegate, ExploreImageDelegate, PeopleRowDelegate  {
    
    let cellId = "cellId"
    let secondaryId = "secondaryId"
    let customRowId = "customRowId"
    let peopleId = "peopleId"
    let principleId = "principleId"
    let exerciseId = "exerciseId"
    let categoryId = "categoryId"
    let discussionId = "discussionId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTopBar()
        
        collectionView?.register(ExploreImageRow.self, forCellWithReuseIdentifier: cellId)
        collectionView?.register(PeopleRow.self, forCellWithReuseIdentifier: peopleId)
        collectionView?.register(ExplorePrinciplesRow.self, forCellWithReuseIdentifier: principleId)
        collectionView?.register(ExploreExerciseRow.self, forCellWithReuseIdentifier: exerciseId)
        collectionView?.backgroundColor = .white
        collectionView?.showsVerticalScrollIndicator = false
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.isHidden = true
    }
    
    
    var users = [User]()
    
    let backgroundFill = UIView()
    let categoryBarBackgroundColor = UIView()
    
    lazy var searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.placeholder = "Search..."
        sb.searchBarStyle = UISearchBarStyle.prominent
        sb.backgroundImage = UIImage(color: .clear)
        sb.delegate = self
        sb.translatesAutoresizingMaskIntoConstraints = false
        sb.barTintColor = .white
        sb.isTranslucent = true
        
        let attributedPlaceholder = NSMutableAttributedString(string: "Search...", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 18), NSAttributedStringKey(rawValue: NSAttributedStringKey.foregroundColor.rawValue): UIColor.gray])
        
        let textFieldPlaceHolder = sb.value(forKey: "searchField") as? UITextField
        textFieldPlaceHolder?.attributedPlaceholder = attributedPlaceholder
        
        return sb
    }()
    
    private func setupTopBar(){
        let guide = view.safeAreaLayoutGuide
        view.addSubview(backgroundFill)
        view.addSubview(searchBar)
        backgroundFill.backgroundColor = .white
        backgroundFill.anchor(top: view.topAnchor, left: guide.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 95)
        searchBar.anchor(top: nil, left: view.leftAnchor, bottom: backgroundFill.bottomAnchor, right: backgroundFill.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: searchBar.intrinsicContentSize.height)
    }
    
    
    func imageTapped() {
        handleChangeToDetail(viewType: "isImageDetail")
    }
    
    func imageHeld() {
        let actionController = SkypeActionController()
        actionController.addAction(Action("Save", style: .default, handler: { action in
            // do something useful
        }))
        actionController.addAction(Action("Like", style: .default, handler: { action in
            // do something useful
        }))
        actionController.addAction(Action("Share", style: .default, handler: { action in
            let text = "This is some text that I want to share."
            let textToShare = [ text ]
            let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view
            self.present(activityViewController, animated: true, completion: nil)
        }))
        actionController.addAction(Action("Cancel", style: .default, handler: {action in
            
        }))
        present(actionController, animated: true, completion: nil)
    }
    
    func explorePrincipleTapped() {
        handleChangeToDetail(viewType: "isPrinciplesDetail")
    }
    
    func explorePrincipleHeld() {
        let actionController = SkypeActionController()
        actionController.addAction(Action("Save", style: .default, handler: { action in
            
        }))
        actionController.addAction(Action("Like", style: .default, handler: { action in
            
        }))
        actionController.addAction(Action("Share", style: .default, handler: { action in
            let text = "This is some text that I want to share."
            let textToShare = [ text ]
            let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view
            self.present(activityViewController, animated: true, completion: nil)
        }))
        
        actionController.addAction(Action("Cancel", style: .default, handler: {action in
            
        }))
        present(actionController, animated: true, completion: nil)
        
    }
    
    
    func explorePursuitHeld() {
        let actionController = SkypeActionController()
        actionController.addAction(Action("Save", style: .default, handler: { action in
            
        }))
        actionController.addAction(Action("Like", style: .default, handler: { action in
            
        }))
        actionController.addAction(Action("Share", style: .default, handler: { action in
            let text = "This is some text that I want to share."
            let textToShare = [ text ]
            let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view
            self.present(activityViewController, animated: true, completion: nil)
        }))
        
        actionController.addAction(Action("Cancel", style: .default, handler: {action in
            
        }))
        present(actionController, animated: true, completion: nil)
    }
    
    func explorePursuitTapped() {
        handleChangeToDetail(viewType: "isPursuitDetail")
    }
    
    func profileTapped() {
        let layout = UICollectionViewFlowLayout()
        let profileController = ProfileController(collectionViewLayout: layout)
        navigationController?.pushViewController(profileController, animated: true)
    }
    
    func handleChangeToDetail(viewType : String) {
        switch viewType {
        case "isPrinciplesDetail":
            let detail = PursuitsDetailController(collectionViewLayout: UICollectionViewFlowLayout())
            detail.principleView()
            navigationController?.pushViewController(detail, animated: true)
        case "isPursuitDetail":
            let detail = PursuitsDetailController(collectionViewLayout: UICollectionViewFlowLayout())
            detail.pursuitView()
            navigationController?.pushViewController(detail, animated: true)
        case "isImageDetail":
            let detail = PursuitsDetailController(collectionViewLayout: UICollectionViewFlowLayout())
            detail.imageView()
            navigationController?.pushViewController(detail, animated: true)
        case "isDiscussionDetail":
            let detail = PursuitsDetailController(collectionViewLayout: UICollectionViewFlowLayout())
            detail.discussionView()
            navigationController?.pushViewController(detail, animated: true)
        default:
            assert(false, "Not a valid view type")
        }
    }
    
    func handleChangeToFeed(viewType : String) {
        switch viewType {
        case "isPrinciplesFeed":
            let feed = HomeController(collectionViewLayout: UICollectionViewFlowLayout())
            feed.principleView()
            navigationController?.pushViewController(feed, animated: true)
        case "isPursuitFeed":
            let feed = HomeController(collectionViewLayout: UICollectionViewFlowLayout())
            feed.pursuitView()
            navigationController?.pushViewController(feed, animated: true)
        case "isImageFeed":
            let feed = HomeController(collectionViewLayout: UICollectionViewFlowLayout())
            feed.imageView(isExplore: true)
            navigationController?.pushViewController(feed, animated: true)
        default:
            assert(false, "Not a valid view type")
        }
    }
}

extension ExploreController {
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.item {
        case 0:
            let imageCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ExploreImageRow
            imageCell.exploreDelegate = self
            imageCell.accessExploreController = self
            return imageCell
        case 1:
            let pursuitCell = collectionView.dequeueReusableCell(withReuseIdentifier: exerciseId, for: indexPath) as! ExploreExerciseRow
            pursuitCell.exploreDelegate = self
            pursuitCell.accessExploreController = self
            return pursuitCell
        case 2:
            let peopleCell = collectionView.dequeueReusableCell(withReuseIdentifier: peopleId, for: indexPath) as! PeopleRow
            peopleCell.peopleDelegate = self
            return peopleCell
        case 3:
            let principleCell = collectionView.dequeueReusableCell(withReuseIdentifier: principleId, for: indexPath) as! ExplorePrinciplesRow
            principleCell.exploreDelegate = self
            principleCell.accessExploreController = self
            return principleCell
        default:
            assert(false, "This is not a valid cell")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.item {
        case 0:
            return CGSize(width: view.frame.width, height: 460)
        case 1:
            return CGSize(width: view.frame.width, height: 310)
        case 2:
            return CGSize(width: view.frame.width, height: 230)
        case 3:
            return CGSize(width: view.frame.width, height: 345)
        default:
            assert(false, "This is not a valid cell")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 70)
    }
}

extension ExploreController : UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        guard let searchText = searchBar.text else { return }
        getSearchContent(searchText: searchText)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            print("Search is empty")
        } else {
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
                guard let _ = response.result.value as? [Dictionary<String,AnyObject>] else { return }
                
            case .failure:
                print("Failure: \(response.result.isSuccess)")
            }
            
        }
    }
}

