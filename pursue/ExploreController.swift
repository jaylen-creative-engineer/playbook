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

class ExploreController : UICollectionViewController, UICollectionViewDelegateFlowLayout, ExploreDiscussionDelegate, ExploreExerciseDelegate, ExplorePrincipleDelegate, ExploreImageDelegate, ExploreCategoryDelegate, PeopleRowDelegate {
    
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
        
        tabBarController?.navigationController?.navigationBar.isHidden = true
        setupCollectionView()
        setupTopBar()
    }
    
    func scrollToMenuIndex(menuIndex: Int) {
        let indexPath = IndexPath(item: menuIndex, section: 0)
        collectionView?.scrollToItem(at: indexPath, at: [], animated: true)
    }
    
    func setupCollectionView(){
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        
        collectionView?.register(ExploreContainer.self, forCellWithReuseIdentifier: cellId)
        collectionView?.backgroundColor = .white
        collectionView?.contentInset = UIEdgeInsetsMake(0, 0, 105, 0)
        collectionView?.isScrollEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    lazy var cameraIcon : UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "add").withRenderingMode(.alwaysOriginal)
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(switchToCamera)))
        return iv
    }()
    
    lazy var homeIcon : UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "Pursuit-typed").withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    @objc func switchToCamera() {
        let layout = UICollectionViewFlowLayout()
        let cameraController = SelectCameraController(collectionViewLayout: layout)
        navigationController?.present(cameraController, animated: true, completion: nil)
    }
    
    lazy var searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.placeholder = "Search..."
        sb.searchBarStyle = UISearchBarStyle.prominent
        sb.backgroundImage = UIImage(color: .clear)
        sb.delegate = self
        sb.barTintColor = .white
        sb.isTranslucent = true
        
        let attributedPlaceholder = NSMutableAttributedString(string: "Search", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 18), NSAttributedStringKey(rawValue: NSAttributedStringKey.foregroundColor.rawValue): UIColor.gray])
        
        let textFieldPlaceHolder = sb.value(forKey: "searchField") as? UITextField
        textFieldPlaceHolder?.attributedPlaceholder = attributedPlaceholder
        
        return sb
    }()
    
    var users = [User]()
    
    let backgroundFill = UIView()
    let categoryBarBackgroundColor = UIView()
    
    private func setupTopBar(){
        let guide = view.safeAreaLayoutGuide
        view.addSubview(backgroundFill)
        view.addSubview(homeIcon)
        view.addSubview(cameraIcon)
        
        backgroundFill.backgroundColor = .white
        
        backgroundFill.anchor(top: view.topAnchor, left: guide.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: (view.frame.height / 8.5) - 5)
        homeIcon.anchor(top: nil, left: backgroundFill.leftAnchor, bottom: backgroundFill.bottomAnchor, right: nil, paddingTop: 8, paddingLeft: 28, paddingBottom: 14, paddingRight: 0, width: 50, height: 18)
        cameraIcon.anchor(top: nil, left: nil, bottom: backgroundFill.bottomAnchor, right: backgroundFill.rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 14, paddingRight: 22, width: 18, height: 16)
        
        setupCategoryBar()
    }
    
    lazy var categoryBar : CategoryBar = {
       let cb = CategoryBar()
        cb.accessExploreController = self
        return cb
    }()
    
    private func setupCategoryBar(){
        view.addSubview(categoryBarBackgroundColor)
        categoryBarBackgroundColor.addSubview(categoryBar)
        categoryBarBackgroundColor.backgroundColor = .white
        
        categoryBarBackgroundColor.anchor(top: homeIcon.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 44)
        categoryBar.anchor(top: categoryBarBackgroundColor.topAnchor, left: categoryBarBackgroundColor.leftAnchor, bottom: nil, right: categoryBarBackgroundColor.rightAnchor, paddingTop: 24, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 60)
    }
    
    // MARK: - Setup View
    
    func showSearchModal(){
        
    }
    
    func exploreCategoryTapped() {
        let layout = UICollectionViewFlowLayout()
        let categoryDetailController = CategoryDetailController(collectionViewLayout: layout)
        navigationController?.pushViewController(categoryDetailController, animated: true)
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
    
    func exploreDiscussionTapped() {
        handleChangeToDetail(viewType: "isDiscussionDetail")
    }
    
    func exploreDiscussionHeld() {
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
        case "isDiscussionFeed":
            let feed = HomeController(collectionViewLayout: UICollectionViewFlowLayout())
            feed.discussionView()
            navigationController?.pushViewController(feed, animated: true)
        default:
            assert(false, "Not a valid view type")
        }
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
                guard let dictionaries = response.result.value as? [Dictionary<String,AnyObject>] else { return }
                for dictionary in dictionaries {
                    print(dictionary)
                    let user = User(dictionary: dictionary)
                    self.users.append(user)
                    print(self.users)
                }
            case .failure:
                print("Failure: \(response.result.isSuccess)")
            }
            
        }
    }
}

extension ExploreController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: (view.frame.height / 8.5) + 50)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ExploreContainer
        return cell
    }
}

