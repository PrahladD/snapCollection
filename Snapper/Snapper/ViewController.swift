//
//  ViewController.swift
//  Snapper
//
//  Created by Prahlad Dhungana on 2022-11-15.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? TestCell else { fatalError() }
        cell.configure(img: images[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.height * 0.95
        return CGSize(width: size, height: size)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        snapCollectonViewCell()
    }
    
    var collectionViewSnappedOnPlace = false
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        if !collectionViewSnappedOnPlace {
            snapCollectonViewCell()
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        collectionViewSnappedOnPlace = !collectionViewSnappedOnPlace
    }
    
    private func snapCollectonViewCell (animated: Bool = true) {
        let bounds = collectionView.bounds
        let xPosition = bounds.midX
        let yPosition = bounds.midY
        let xyPoint = CGPoint(x: xPosition, y: yPosition)
 
    
        var indexPath = collectionView.indexPathForItem(at: xyPoint)
        
        if indexPath == nil {
            indexPath =   collectionView.indexPathForItem(at: CGPoint(x: xPosition + 15, y: yPosition))
        }
        
        selectCell(at: indexPath, animated: animated)
    }
    
    private func selectCell(at indexPath: IndexPath?, animated: Bool) {
        guard let indexPath = indexPath else { return }
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: animated)
        glassImg.image = images[indexPath.row]
        collectionViewSnappedOnPlace = true
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectCell(at: indexPath, animated: true)
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        if !decelerate {
            snapCollectonViewCell()
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
    
//    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
//        scrollViewDidEndDecelerating(scrollView)
//    }
    
    @IBOutlet weak var glassImg: UIImageView!
    @IBOutlet weak var circularView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        designView()
        setCollectionView()
        
        for i in 1...10 {
            images.append(UIImage(named: "\(i)"))
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        selectCell(at: IndexPath(row: 0, section: 0), animated: false)
    }

    var images: [UIImage?] = []
    
    private func setCollectionView() {
        collectionView.decelerationRate = UIScrollView.DecelerationRate.fast
        let layout = CustomCollectionViewLayout()
        collectionView.collectionViewLayout = layout
        let nib = UINib(nibName: "TestCell", bundle: .main)
        collectionView.register(nib, forCellWithReuseIdentifier: "cell")
        //collectionView.register(TestCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    

    private func designView() {
        circularView.clipsToBounds = true
        circularView.backgroundColor = .clear
        circularView.layer.borderWidth = 3
        circularView.layer.cornerRadius = circularView.frame.width / 2
        circularView.layer.borderColor = UIColor.systemOrange.cgColor    }
}
