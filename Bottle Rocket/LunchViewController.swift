//
//
//  Bottle Rocket
//
//  Created by Teodora Mratinkovic on 11/24/21.
//

import UIKit

private struct Identifiers {

    static let main: String = "Main"
    static let restaurantMap: String = "RestaurantMap"
    static let showDetails: String = "ShowDetails"
    static let collectionViewCell: String = "CollectionViewCell"
}

class LunchViewController: UIViewController {
  
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var restaurants: [Restaurant] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
 
    @IBOutlet weak var openMapFullScreen: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        setupTabBar()
        loadData()
    }
    
    override func willRotate(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
           collectionView.collectionViewLayout.invalidateLayout()
       }
    
    
    private func setupTabBar() {
        let internetsVC = InternetViewController()
        let tabBarItem = UITabBarItem(title: StringConstants.internets,
                                      image: UIImage(named: AssetConstants.tabInternets),
                                      tag: 1)
        internetsVC.tabBarItem = tabBarItem
        let internetsNavigationController = UINavigationController(rootViewController: internetsVC)
        tabBarController?.viewControllers?.append(internetsNavigationController)
    }
    
    private func loadData() {
        RestaurantsManager.getRestaruants { restaurants in
            DispatchQueue.main.async {
                self.restaurants = restaurants
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let cell = sender as? CollectionViewCell else { return }
        guard let controller = segue.destination as? DetailViewController else { return }
        controller.restaurant = cell.restaurant
    }
   
}


extension LunchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return restaurants.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.collectionViewCell, for: indexPath) as? CollectionViewCell else { return UICollectionViewCell() }
        let item = restaurants[indexPath.row]
        cell.restaurant = item
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        performSegue(withIdentifier: Identifiers.showDetails, sender: cell)
    }
}

extension LunchViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var columnNumber: CGFloat = UIDevice.current.orientation.isLandscape || UIDevice.current.userInterfaceIdiom != .phone ? 2 : 1
        if !restaurants.count.isMultiple(of: 2) && indexPath.row == restaurants.count - 1 {
            columnNumber = 1
        }
        return CGSize(width: view.bounds.width, height: 180)
    }
}
