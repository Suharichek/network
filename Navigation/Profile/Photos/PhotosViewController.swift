//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Suharik on 04.04.2022.
//

import UIKit
import SnapKit
import iOSIntPackage

class PhotosViewController: UIViewController {
    private let facade = ImagePublisherFacade()
    private var newPhotoArray = [UIImage]()
    private let itemsPerRow: CGFloat = 3
    let sectionInserts = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    private let imageProcessor = ImageProcessor()
    private var count: Double = 0
    private var timer: Timer?
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        layout.sectionInset = sectionInserts
        layout.scrollDirection = .vertical
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: PhotosCollectionViewCell.identifire)
        collection.dataSource = self
        collection.delegate = self
        return collection
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.center = self.view.center
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        view.addSubview(activityIndicator)
        collectionView.backgroundColor = .white
        collectionView.snp.makeConstraints { make in
            make.leading.top.trailing.bottom.equalTo(self.view)
        }
        //        facade.subscribe(self)
        //        facade.addImagesWithTimer(time: 0.5, repeat: 20, userImages: filtredPhotosArray)
        activityIndicator.startAnimating()
        imageProcessor.processImagesOnThread(sourceImages: filtredPhotosArray, filter: .colorInvert, qos: QualityOfService.userInteractive) { [unowned self] cgImages in
            self.newPhotoArray = cgImages.map({UIImage(cgImage: $0!)})
            DispatchQueue.main.async{
                self.collectionView.reloadData()
                self.activityIndicator.stopAnimating()
                
            }
        }
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.035, repeats: true, block: { [weak self] _ in
            self?.count += 0.035
            self?.checkTimer()
        })
    }
    //    deinit {
    //        facade.rechargeImageLibrary()
    //        facade.removeSubscription(for: self)
    //    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func checkTimer() {
        if !newPhotoArray.isEmpty {
            print("Затраченное время: \(TimeCheck.timeToString(sec: count))")
            TimeCheck.showElapsedTimeAlert(navCon: self.navigationController!, sec: count)
            timer!.invalidate()
        }
    }
}

extension PhotosViewController: UICollectionViewDataSource, ImageLibrarySubscriber {
    
    func receive(images: [UIImage]) {
        newPhotoArray = images
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newPhotoArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.identifire, for: indexPath) as? PhotosCollectionViewCell else { return UICollectionViewCell() }
        cell.configure(image: newPhotoArray[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingWidth = sectionInserts.left * (itemsPerRow + 1)
        let availableWidth = collectionView.frame.width - paddingWidth
        let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
}
