//
//  OnlineUsersViewController.swift
//  ChatApp
//
//  Created by Umer Jabbar on 19/06/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class OnlineUsersViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var viewHeightConstraint: NSLayoutConstraint!
    
    var viewModel = ConversationsViewModel()
    
    var topSafeArea: CGFloat = 0.0
    var bottomSafeArea: CGFloat = 0.0
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        if #available(iOS 11.0, *) {
            topSafeArea = view.safeAreaInsets.top
            bottomSafeArea = view.safeAreaInsets.bottom
        } else {
            topSafeArea = topLayoutGuide.length
            bottomSafeArea = bottomLayoutGuide.length
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.openWide()
    }
    
    func openWide(){
        UIView.animate(withDuration: 200) {
            self.viewHeightConstraint.constant = self.view.frame.height - self.topSafeArea - self.bottomSafeArea - 70
            if let layout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                layout.scrollDirection = .vertical
            }
        }
    }
    
    func closeWide(){
        UIView.animate(withDuration: 200, animations: {
            self.viewHeightConstraint.constant = 117
            if let layout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                layout.scrollDirection = .horizontal
            }
        }) { (value) in
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        self.closeWide()
    }
    
}

extension OnlineUsersViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.onlineUsers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnlineUserCollectionViewCell", for: indexPath) as! OnlineUserCollectionViewCell
        
        cell.setup(item: self.viewModel.onlineUsers[indexPath.item])
        
        return cell
    }
    
}

extension OnlineUsersViewController : UICollectionViewDelegate {
    
}

extension OnlineUsersViewController : ConversationsResponseDelegate {
    
    func onlineUsersReceived() {
        self.collectionView.reloadData()
    }
    
    func messageHeadsReceived() {
        
    }
    
}
