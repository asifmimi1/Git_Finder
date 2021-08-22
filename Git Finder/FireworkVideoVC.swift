//
//  FireworkVideoVC.swift
//  Git Finder
//
//  Created by Asif Rabbi on 22/8/21.
//

import UIKit
import FireworkVideo

class FireworkVideoVC: UIViewController {
    
    var embeddedVideoFeedViewController : VideoFeedViewController!
    var layoutPicker: UISegmentedControl!
    
    var targetAction: SenderSuppliedTargetAction?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.secondarySystemBackground
        self.embeddedVideoFeedViewController = VideoFeedLayoutTypes.horizontalViewController
        self.setupLayoutPicker()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupVideoFeed(videoFeedViewController: self.embeddedVideoFeedViewController,
                            fullHeight: false)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.removeVideoFeed(videoFeedViewController: self.embeddedVideoFeedViewController)
        super.viewDidDisappear(animated)
    }
    
    private func setupLayoutPicker() {
        self.layoutPicker = UISegmentedControl()
        
        self.layoutPicker.insertSegment(withTitle: "Horizontal",
                                        at: 0,
                                        animated: false)
        self.layoutPicker.insertSegment(withTitle: "Vertical",
                                        at: 1,
                                        animated: false)
        self.layoutPicker.insertSegment(withTitle: "Grid",
                                        at: 2,
                                        animated: false)
        self.layoutPicker.selectedSegmentIndex = 0
        
        let targetAction = SenderSuppliedTargetAction { sender in
            if let segmentedControl = sender as? UISegmentedControl {
                self.removeVideoFeed(videoFeedViewController: self.embeddedVideoFeedViewController)
                
                switch segmentedControl.selectedSegmentIndex {
                case 0:
                    self.embeddedVideoFeedViewController = VideoFeedLayoutTypes.horizontalViewController
                    self.setupVideoFeed(videoFeedViewController: self.embeddedVideoFeedViewController,
                                        fullHeight: false)
                case 1:
                    self.embeddedVideoFeedViewController = VideoFeedLayoutTypes.verticalViewController
                    self.setupVideoFeed(videoFeedViewController: self.embeddedVideoFeedViewController)
                case 2:
                    self.embeddedVideoFeedViewController = VideoFeedLayoutTypes.gridViewController
                    self.setupVideoFeed(videoFeedViewController: self.embeddedVideoFeedViewController)
                default:
                    break
                }
                
                
            }
        }
        self.layoutPicker.addTarget(targetAction,
                                    action: #selector(SenderSuppliedTargetAction.performAction(_:)),
                                    for: .valueChanged)
        self.targetAction = targetAction
        
        self.layoutPicker.tintColor = UIColor.secondarySystemGroupedBackground
        self.layoutPicker.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.layoutPicker)
        
        self.layoutPicker.leadingAnchor.constraint(equalTo:self.view.safeAreaLayoutGuide.leadingAnchor,
                                                   constant: 8.0).isActive = true
        self.layoutPicker.trailingAnchor.constraint(equalTo:self.view.safeAreaLayoutGuide.trailingAnchor,
                                                    constant: -8.0).isActive = true
        self.layoutPicker.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,
                                               constant: 20.0).isActive = true
    }
    
}


extension UIViewController {
    
    func removeVideoFeed(videoFeedViewController: VideoFeedViewController) {
        videoFeedViewController.willMove(toParent: nil)
        videoFeedViewController.view.removeFromSuperview()
        videoFeedViewController.removeFromParent()
    }
    
    /// In addition to embedding the view feed, this method sets up constraints
    func setupVideoFeed(videoFeedViewController: VideoFeedViewController,
                        topSpacing: CGFloat = 80.0,
                        fullHeight: Bool = true) {
        
        self.addChild(videoFeedViewController)
        self.view.addSubview(videoFeedViewController.view)
        videoFeedViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        videoFeedViewController.view.leadingAnchor.constraint(equalTo:self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        videoFeedViewController.view.trailingAnchor.constraint(equalTo:self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        videoFeedViewController.view.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,
                                                          constant: topSpacing).isActive = true
        
        if fullHeight {
            videoFeedViewController.view.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor,
                                                                 constant: -topSpacing).isActive = true
        } else {
            videoFeedViewController.view.heightAnchor.constraint(equalToConstant: 280.0).isActive = true
        }
        
        videoFeedViewController.didMove(toParent: self)
    }
}
