//
//  ViewController.swift
//  DesignCodeApp
//
//  Created by Kyla Wilson on 10/1/20.
//

import UIKit
import AVKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var deviceImageView: UIImageView!
    @IBOutlet weak var playVisualView: UIVisualEffectView!
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var heroView: UIView!
    @IBOutlet weak var bookView: UIView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var chapterCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView.delegate = self
        chapterCollectionView.dataSource = self
        chapterCollectionView.delegate = self
        
        titleLabel.alpha = 0
        deviceImageView.alpha = 0
        playVisualView.alpha = 0
        
        UIView.animate(withDuration: 1) {
            self.titleLabel.alpha = 1
            self.deviceImageView.alpha = 1
            self.playVisualView.alpha = 1
        }
    }

    @IBAction func PlayButtonTapped(_ sender: Any) {
        let urlString = "https://player.vimeo.com/external/235468301.hd.mp4?s=e852004d6a46ce569fcf6ef02a7d291ea581358e&profile_id=175"
        guard let url = URL(string: urlString) else { return }
        let player = AVPlayer(url: url)
        
        let playViewController = AVPlayerViewController()
        playViewController.player = player
        
        self.present(playViewController, animated: true) {
            player.play()
        }
    }
}

extension HomeViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        
        if offsetY < 0 {
            heroView.transform = CGAffineTransform(translationX: 0, y: offsetY)
            playVisualView.transform = CGAffineTransform(translationX: 0, y: -offsetY / 3)
            titleLabel.transform = CGAffineTransform(translationX: 0, y: -offsetY / 3)
            deviceImageView.transform = CGAffineTransform(translationX: 0, y: -offsetY / 4)
            backgroundImageView.transform = CGAffineTransform(translationX: 0, y: -offsetY / 5)
        }
        
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SectionCell", for: indexPath)
        return cell
    }
    
    
}

