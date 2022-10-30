//
//  ViewController.swift
//  Rick-and-Morty-
//
//  Created by Ali  Farizli  on 27.10.22.
//

import UIKit

class ViewController: UIViewController {
    
    private let filterTypes: [String] = ["Gender", "Species", "State"]
    @IBOutlet weak var charactersCV: UICollectionView!{
        didSet {
            charactersCV.dataSource = self
            charactersCV.delegate = self
        }
    }
    @IBOutlet weak var filterCV: UICollectionView! {
        didSet {
//            filterCV.isHidden = true
            filterCV.dataSource = self
            filterCV.delegate = self
        }
    }
    @IBOutlet weak var filterBtn: FilterButton!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        setBindings()
        charactersCV.addSubview(self.refreshControl)
        vm.getChars(page: pageNumber)
        
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
    
    @IBAction func filterBtnTapped(_ sender: FilterButton) {
        filterBtn.isTapped.toggle()
        tableView.isHidden.toggle()
        
        showMenu = !showMenu
        
        var indexPaths = [IndexPath]()
        
        filterTypes.forEach { (type) in
            let indexPath = IndexPath(row: filterTypes.firstIndex(where: { $0  == type }) ?? 0, section: 0)
            indexPaths.append(indexPath)
        }
        
        if showMenu {
            view.alpha = 0.8
            tableView.insertRows(at: indexPaths, with: .fade)
        } else {
            view.alpha = 1
            tableView.deleteRows(at: indexPaths, with: .fade)
        }
    }
    
    var tableView: UITableView!
    var showMenu = false


    func configureTableView() {
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.isHidden = true
        
        tableView.isScrollEnabled = false
        tableView.rowHeight = 50
        
        tableView.register(FilterTVCell.self, forCellReuseIdentifier: "FilterTVCell")
        
        
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: filterBtn.bottomAnchor, constant: 10).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        tableView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return showMenu == true ? filterTypes.count : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilterTVCell", for: indexPath) as! FilterTVCell
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        cell.label.text = filterTypes[indexPath.row]
        return cell
    }
    
    
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case charactersCV:
            return self.characters?.count ?? 0
        case filterCV:
            return 5
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
            print("")
            
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
                    self.vm.getChars(page: self.pageNumber)
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
            self.characters?.append(contentsOf: data?.results ?? [])
            print("charactersData", self.charactersData)
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
        return 15
    }

}


