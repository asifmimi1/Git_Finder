//
//  VideoFeedLayoutTypes.swift
//  Git Finder
//
//  Created by Asif Rabbi on 22/8/21.
//
import UIKit
import Foundation
import FireworkVideo

class VideoFeedLayoutTypes {
    
    static func configureHorizontalVideoFeedViewController() -> VideoFeedViewController {
        let vc = VideoFeedViewController()
        let layout = VideoFeedHorizontalLayout()
        layout.itemSpacing = 8
        layout.contentInsets = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
        vc.layout = layout
        var config = vc.viewConfiguration
        config.backgroundColor = UIColor.systemGray
        config.itemView.cornerRadius = 12
        config.itemView.titleLayoutConfiguration.insets = UIEdgeInsets(top: 10, left: 4, bottom: 0, right: 4)
        config.itemView.title.isHidden = false
        config.itemView.title.font = UIFont.preferredFont(forTextStyle: .body).withSize(12.0)
        config.itemView.title.numberOfLines = 2
        config.itemView.title.textColor = UIColor.white.withAlphaComponent(0.9)
        config.itemView.titleLayoutConfiguration.titlePosition = .stacked
        vc.viewConfiguration = config
        return vc
    }
    
    static func configureVerticalVideoFeedViewController() -> VideoFeedViewController {
        let verticalVC = VideoFeedViewController()
        let layout = VideoFeedGridLayout()
        layout.numberOfColumns = 1
        layout.contentInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.itemSpacing = 20
        verticalVC.layout = layout
        var config = verticalVC.viewConfiguration
        config.backgroundColor = .white
        verticalVC.viewConfiguration = config
        return verticalVC
    }
    
    static func configureGridVideoFeedViewController() -> VideoFeedViewController {
        let gridVC = VideoFeedViewController()
        gridVC.view.backgroundColor = .systemBackground
        let layout = VideoFeedGridLayout()
        layout.numberOfColumns = 3
        layout.contentInsets = UIEdgeInsets(top: 16, left: 8, bottom: 16, right: 8)
        gridVC.layout = layout
        var config = gridVC.viewConfiguration
        config.backgroundColor = .white
        gridVC.viewConfiguration.playerView.videoCompleteAction = .loop
        gridVC.viewConfiguration = config
        return gridVC
    }
    
    static var horizontalViewController: VideoFeedViewController {
        return VideoFeedLayoutTypes.configureHorizontalVideoFeedViewController()
    }
    
    static var verticalViewController: VideoFeedViewController {
        return VideoFeedLayoutTypes.configureVerticalVideoFeedViewController()
    }
    
    static var gridViewController: VideoFeedViewController {
        return VideoFeedLayoutTypes.configureGridVideoFeedViewController()
    }
    
    static func horizontalVideoFeedLayout() -> VideoFeedHorizontalLayout {
        let layout = VideoFeedHorizontalLayout()
        layout.itemSpacing = 8
        layout.contentInsets = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
        return layout
    }
}
