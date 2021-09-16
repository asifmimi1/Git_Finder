//
//  FireworkVideoVC.swift
//  Git Finder
//
//  Created by Asif Rabbi on 22/8/21.
//

import UIKit
import FireworkVideo

class VideoFeedCell: UITableViewCell {
    static let reuseIdentifier = "VideoFeedCellReuseIdentifier"
    
}

class FireworkVideoVC: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    lazy var videoFeedViewController: VideoFeedViewController = self.configuredFeedViewController()
    
    lazy var tableView: UITableView = self.configureTableView()
    var contentSource = VideoFeedContentSource.channelPlaylist(channelID: "4Y9XaK0", playlistID: "5aMPy5")
    
    //    @available(*, unavailable)
    //    required init?(coder aDecoder: NSCoder) {
    //        super.init(coder: aDecoder)
    //    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.systemBackground
        self.setup()
    }
    
    private func setup() {
        self.view.addSubview(self.tableView)
        self.view.safeAreaLayoutGuide.leadingAnchor.constraint(equalTo: self.tableView.leadingAnchor).isActive = true
        self.view.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: self.tableView.trailingAnchor).isActive = true
        self.view.safeAreaLayoutGuide.topAnchor.constraint(equalTo: self.tableView.topAnchor).isActive = true
        self.view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: self.tableView.bottomAnchor).isActive = true
    }
    
    
    /// Only the horizontal layout supports embedding inside of UITableView
    /// or UICollectionView.
    private func configuredFeedViewController() -> VideoFeedViewController {
        let viewController = VideoFeedViewController(source: self.contentSource)
        let layout = VideoFeedHorizontalLayout()
        layout.itemSpacing = 8
        layout.contentInsets = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
        viewController.layout = layout
        var config = viewController.viewConfiguration
        config.backgroundColor = UIColor.clear
        config.itemView.cornerRadius = 12
        config.itemView.titleLayoutConfiguration.insets = UIEdgeInsets(top: -36, left: 6, bottom: 0, right: 4)
        config.itemView.title.isHidden = false
        config.itemView.title.font = UIFont.systemFont(ofSize: 12)
        config.itemView.title.numberOfLines = 2
        config.itemView.title.textColor = UIColor.white.withAlphaComponent(0.9)
        config.itemView.titleLayoutConfiguration.titlePosition = .stacked
        viewController.viewConfiguration = config
        return viewController
    }
    
    private func configureTableView() -> UITableView {
        let tableView = UITableView(frame: .zero, style: .grouped)
        
        tableView.register(VideoFeedCell.self,
                           forCellReuseIdentifier: VideoFeedCell.reuseIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.delegate = self
        tableView.dataSource = self
        
        return tableView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = UITableViewCell(style: .subtitle,reuseIdentifier: "")
            cell.textLabel?.text = NSLocalizedString("Moments",comment: "")
            return cell
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: VideoFeedCell.reuseIdentifier,for: indexPath) as! VideoFeedCell
            //            let newView = UIView(frame: CGRect(x: 300, y: 0, width: 110, height: 50))
            //            newView.backgroundColor = .black.withAlphaComponent(0.9)
            //            cell.addSubview(newView)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            self.addChild(self.videoFeedViewController)
            cell.contentView.addSubview(videoFeedViewController.view)
            
            self.videoFeedViewController.view.translatesAutoresizingMaskIntoConstraints = false
            
            cell.contentView.safeAreaLayoutGuide.leadingAnchor.constraint(equalTo: videoFeedViewController.view.leadingAnchor).isActive = true
            cell.contentView.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: videoFeedViewController.view.trailingAnchor).isActive = true
            cell.contentView.safeAreaLayoutGuide.topAnchor.constraint(equalTo: videoFeedViewController.view.topAnchor).isActive = true
            cell.contentView.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: videoFeedViewController.view.bottomAnchor).isActive = true
            
            self.videoFeedViewController.willMove(toParent: self)
        }
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            videoFeedViewController.willMove(toParent: nil)
            videoFeedViewController.view.removeFromSuperview()
            videoFeedViewController.removeFromParent()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 0 ? 100.0 : 200.0
    }
    
}
