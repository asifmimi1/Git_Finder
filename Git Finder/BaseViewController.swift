//
//  ViewController.swift
//  Git Finder
//
//  Created by Asif Mimi Rabbi on 3/8/21.
//

import UIKit
import Alamofire
import SDWebImage
import AVKit
import AVFoundation
import FirebaseStorage
import FirebaseCore
import SVProgressHUD
import FireworkVideo
import FBSDKCoreKit
import Firebase
import FBSDKCoreKit

class BaseViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    @IBOutlet weak var gitFinderTableView: UITableView!
    
    var users = [UsersInfo]()
    let imagePickerController = UIImagePickerController()
    let storage = Storage.storage()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        alamoFireRequest(requestURL: "https://api.github.com/users")
        let editButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(toggleEditing))
        navigationItem.rightBarButtonItem = editButton
        
        //MARK: Facebook Events
        Settings.setAdvertiserTrackingEnabled(true)
        AppEvents.logEvent(.viewedContent)
        AppEvents.logEvent(AppEvents.Name(rawValue: "Test_Event_new"), parameters: ["test_event_new": "2"])
        
        //MARK: Firebase Events
        let timestamp = NSDate().timeIntervalSince1970
        let timeInterval = TimeInterval(timestamp)
        let time = NSDate(timeIntervalSince1970: TimeInterval(timeInterval))
//        Analytics.logEvent("Git Finder Launched", parameters: ["Time" : "\(time)"])
        
//        let id = UIDevice.current.identifierForVendor?.uuidString
//        print(id! as Any)
        
        
        let name = "Asif"
        let parameters: [String: Any] = [
            "asif": "asif"
        ]

        let event = AppEvents.Name(name)
        AppEvents.logEvent(event, parameters: parameters)
    }
    
    @IBAction func crashButtonTapped(_ sender: AnyObject) {
//                        let numbers = [0]
//                        let _ = numbers[1]
//        imagePickerController.sourceType = .photoLibrary
//        imagePickerController.delegate = self
//        imagePickerController.mediaTypes = ["public.image", "public.movie"]
//        present(imagePickerController, animated: true, completion: nil)
    }
    
    // UIImagePickerController Delegate Method
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let pickedVideo = info[UIImagePickerController.InfoKey(rawValue: UIImagePickerController.InfoKey.mediaURL.rawValue)] as? URL {
            uploadVideoToDB(url: pickedVideo)
            //            videoPlayer(pickedVideo)
            picker.dismiss(animated: true, completion: nil)
        }
    }
    
    func uploadVideoToDB(url: URL){
        
        let filename = UUID().uuidString
        let storageRef = storage.reference().child("videos").child("\(filename).mp4")
        let metadata = StorageMetadata()
        metadata.contentType = "video/quicktime"
        
        if let videoData = NSData(contentsOf: url) as Data? {
            let uploadTask = storageRef.putData(videoData, metadata: metadata)
            uploadTask.observe(.progress) { (snapshot) in
                
                if let completedUnitCount = snapshot.progress?.completedUnitCount,
                   
                   let totalUnitCount = snapshot.progress?.totalUnitCount {
                    let uploadProgress:Float = Float(completedUnitCount) / Float(totalUnitCount)
                    let percentComplete = 100.0 * Double(completedUnitCount) / Double(totalUnitCount)
                    let uploadPercentage = String(format: "%.0f", floor(percentComplete))
                    SVProgressHUD.showProgress( uploadProgress , status: "Uploading \(uploadPercentage)%")
                    if uploadPercentage == "100"{
                        SVProgressHUD.dismiss()
                    }
                }
            }
        }
    }
    
    
    
    func videoPlayer(_ videoUrl :URL){
        let player = AVPlayer(url: videoUrl)
        let playerController = AVPlayerViewController()
        playerController.player = player
        self.present(playerController, animated: true) {player.play()
        }
    }
    
    @objc private func toggleEditing() {
//        gitFinderTableView.setEditing(!gitFinderTableView.isEditing, animated: true)
//        navigationItem.rightBarButtonItem?.title = gitFinderTableView.isEditing ? "Done" : "Edit"
        
//        let goToVideoFeedViewController = storyboard?.instantiateViewController(identifier: "FireworkVideoVC") as? FireworkVideoVC
//        self.navigationController?.pushViewController(goToVideoFeedViewController!,animated: true)

        let goToVideoFeedViewController = storyboard?.instantiateViewController(identifier: "LineChartViewController") as? LineChartViewController
        self.navigationController?.pushViewController(goToVideoFeedViewController!,animated: true)
    }
        
    func alamoFireRequest(requestURL: String) {
        AF.request(requestURL, method: .get, encoding: URLEncoding.default).responseJSON { [self] responseData in
            
            guard let jsonData = responseData.data else {return}
            let decoder = JSONDecoder()
            do {
                self.users = try decoder.decode([UsersInfo].self, from: jsonData)
            } catch {
                print("getDataL Unexpected error: \(error).")
            }
            gitFinderTableView.reloadData()
        }
    }
}

extension BaseViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepoCellTVC") as! RepoCellTVC
        let user = users[indexPath.row]
        cell.nameLbl.text = user.login
        cell.repoUrlLbl.text = user.url
        cell.profileImg.sd_setImage(with: URL(string: user.avatarUrl!))
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        gitFinderTableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            users.remove(at: indexPath.row)
            gitFinderTableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    //Mark:- Disables the edit button
    //    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
    //        return .none
    //    }
    //    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
    //        return false
    //    }
    
    //Mark:- Movable Table View cell
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedObject = self.users[sourceIndexPath.row]
        users.remove(at: sourceIndexPath.row)
        users.insert(movedObject, at: destinationIndexPath.row)
    }
}

