//
//  ViewController.swift
//  Rick-and-Morty-
//
//  Created by Ali  Farizli  on 27.10.22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var searchField: UITextField!{
        didSet{
            searchField.delegate = self

        }
    }
    
    
    private let filterTypes: [String] = ["Name", "Gender", "Species", "Status"]
    var selectedFilterType = 0
    


    @IBOutlet weak var charactersCV: UICollectionView!{
        didSet {
            charactersCV.dataSource = self
            charactersCV.delegate = self
        }
    }
    @IBOutlet weak var filterCV: UICollectionView! {
        didSet {
            filterCV.dataSource = self
            filterCV.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBindings()
        charactersCV.addSubview(self.refreshControl)
        vm.getChars()
        
    }
    var pageNumber = 1
    var charactersData: ApiData?
    var characters: [Results]? = []
    var reachedBottom = false
    
    lazy var refreshControl: UIRefreshControl = {
            let refreshControl = UIRefreshControl()
            refreshControl.addTarget(self, action:
                         #selector(ViewController.handleRefresh(_:)),
                         for: .valueChanged)
            refreshControl.tintColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            
            return refreshControl
        }()
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
            
            self.charactersCV.reloadData()
            refreshControl.endRefreshing()
        }
    
    lazy var vm = FirstVM()
    var showMenu = false


   
}


extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case charactersCV:
            return self.characters?.count ?? 0
        case filterCV:
            return self.filterTypes.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case charactersCV:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharacterCVCell", for: indexPath) as! CharacterCVCell
            cell.contentView.layer.cornerRadius = 15
            cell.setupCell(species: self.characters?[indexPath.row].species ?? "", gender: self.characters?[indexPath.row].gender ?? "", state: self.characters?[indexPath.row].status ?? "", name: self.characters?[indexPath.row].name ?? "", img: self.characters?[indexPath.row].image ?? URL(fileURLWithPath: ""))
            return cell
        case filterCV:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterCVCell", for: indexPath) as! FilterCVCell
            cell.filterTypeTitle.text = filterTypes[indexPath.row]
            cell.contentView.alpha = indexPath.row == selectedFilterType ? 1 : 0.5
            
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case charactersCV:
            if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SecondViewController") as? SecondViewController {
                viewController.selectedCharData = self.characters?[indexPath.row]
                  if let navigator = navigationController {
                      navigator.pushViewController(viewController, animated: true)
                  }
              }
        case filterCV:
            selectedFilterType = indexPath.row
            collectionView.reloadData()
            
        default:
            print("")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == (characters?.count ?? 0) - 1{
            if pageNumber < charactersData?.info?.pages ?? 0{
                pageNumber += 1
                self.reachedBottom = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    self.vm.getNextChars(title: self.filterTypes[self.selectedFilterType], text: self.searchField.text ?? "")
                    self.reachedBottom = false

                })

            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CollectionReusableView", for: indexPath) as! CollectionReusableView
        if self.reachedBottom == true {
            view.spinner.startAnimating()
            return view
        }else{
            view.spinner.stopAnimating()
            return view
        }
        
    }
}

extension ViewController {
    func setBindings() {
        vm.success = { data in
            self.charactersData = data
            self.characters = data?.results
            
            print("charactersData", self.charactersData)
            DispatchQueue.main.async {
                self.charactersCV.reloadData()
            }
        }
        
        vm.successOnNext = { data in
            self.characters?.append(contentsOf: data?.results ?? [])
            DispatchQueue.main.async {
                self.charactersCV.reloadData()
            }
        }
        
        vm.error = { error in
            let alert = UIAlertController(title: "ERROR", message: error, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)

            
        }
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (charactersCV.bounds.size.width / 2) - 10, height: 230)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

}



extension ViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.vm.getChars(title: filterTypes[selectedFilterType], text: textField.text ?? "")    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
            
        self.vm.getChars(title: filterTypes[selectedFilterType], text: textField.text ?? "")
        
        return true
        }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            self.view.endEditing(true)
        
        return false
    }
    
    
}
