//
//  FullScreenViewController.swift
//  SplashApp
//
//  Created by Baya Walid on 03/10/2022.
//

import UIKit
import SDWebImage
import IHProgressHUD

class FullScreenViewController: PannableViewController {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var saveButton: UIImageView!
    @IBOutlet weak var shareButton: UIImageView!
    var picUrl: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let url = picUrl {
            imgView.sd_setImage(with: URL(string: url), completed: nil)
        }
        
        var tap = UITapGestureRecognizer(target: self, action: #selector(sharePicture))
        shareButton.addGestureRecognizer(tap)
        tap = UITapGestureRecognizer(target: self, action: #selector(savePicture))
        saveButton.addGestureRecognizer(tap)
    }
    
    @objc func sharePicture() {
        var dataToSend : [Any] = []
        dataToSend.append(imgView.image ?? UIImage())
        UIApplication.share(dataToSend)
    }
    
    @objc func savePicture() {
        let imageSaver = ImageSaver()
        imageSaver.writeToPhotoAlbum(image: imgView.image ?? UIImage())
    }
}

class ImageSaver: NSObject {
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
    }

    @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        let alert = UIAlertController(title: "Enregistrée!", message: "Image enregistrée avec succès.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okAction)
        UIApplication.topViewController()?.present(alert, animated: true)
    }
}
