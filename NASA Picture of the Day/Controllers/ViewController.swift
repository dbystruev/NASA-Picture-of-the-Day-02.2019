//
//  ViewController.swift
//  NASA Picture of the Day
//
//  Created by Denis Bystruev on 14/02/2019.
//  Copyright © 2019 Denis Bystruev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var copyrightLabel: UILabel!
    
    var dataRequested = false
    
    var date = Date()
    
    var photoInfo: PhotoInfo? {
        didSet {
            updateUI()
        }
    }
    
    let url = URL(string: "https://api.nasa.gov/planetary/apod")!
    
    var query = [
        "api_key": "DEMO_KEY",
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        requestData()
    }
    
    func requestData() {
        dataRequested = true
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        let date = formatter.string(from: self.date)
        query["date"] = date
        copyrightLabel.text = date
        
        PhotoInfoController.shared.fetchPhotoInfo(url: url.withQueries(query)) { photoInfo in
            guard let photoInfo = photoInfo else {
                self.dataRequested = false
                return
            }
            
            self.photoInfo = photoInfo
            
            PhotoInfoController.shared.fetchImage(url: photoInfo.url, completion: { image in
                guard let image = image else {
                    self.dataRequested = false
                    return
                }
                
                DispatchQueue.main.async {
                    self.photoImageView.image = image
                }
                
                self.dataRequested = false
            })
        }
    }

    func updateUI() {
        guard let photoInfo = photoInfo else { return }
        
        DispatchQueue.main.async {
            self.titleLabel.text = photoInfo.title
            self.descriptionLabel.text = photoInfo.description
            self.copyrightLabel.text = photoInfo.copyright
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        date = date.addingTimeInterval(-60 * 60 * 24)
        
        guard !dataRequested else { return }
        
        requestData()
    }

}

