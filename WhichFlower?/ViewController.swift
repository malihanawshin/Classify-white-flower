//
//  ViewController.swift
//  WhichFlower?
//
//  Created by Maliha on 10/7/24.
//

import UIKit
import CoreML
import Vision
import Alamofire
import SwiftyJSON
import SDWebImage

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var pickedImageView: UIImageView!
    @IBOutlet weak var imageDescription: UILabel!
    
    let imagePicker = UIImagePickerController()
    let wikipediaURl = "https://en.wikipedia.org/w/api.php"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = true
    }

    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let userPickedImageInfo = info[UIImagePickerController.InfoKey.editedImage]
        //pickedImageView.image = userPickedImageInfo as? UIImage
        
        guard let convertedCiimage = CIImage(image: userPickedImageInfo as! UIImage) else {
            fatalError("couldn't convert UI image to CI image")
        }
        detect(image: convertedCiimage)
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func cameraSelected(_ sender: UIBarButtonItem) {
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    func detect(image: CIImage){
     
        guard let model = try? VNCoreMLModel(for: WhiteFlowerClassifier().model) else {
            fatalError("Loading core ML model failed")
        }
        
        let request = VNCoreMLRequest(model: model){(request,error) in
            guard let results = request.results as? [VNClassificationObservation] else {
                fatalError("Model failed to process image")
            }
            //print(results)
            
            if let firstResults = results.first{
                self.navigationItem.title = firstResults.identifier.capitalized
                
                self.getInfo(flowerName: firstResults.identifier)
            }
            
            
            
        }
        
        let handler = VNImageRequestHandler(ciImage: image)
        do{
            try handler.perform([request])
        } catch {
            print(error)
        }
        
    }
    
    func getInfo(flowerName: String){
        
        let parameters : [String:String] = [
          "format" : "json",
          "action" : "query",
          "prop" : "extracts|pageimages",
          "exintro" : "",
          "explaintext" : "",
          "titles" : flowerName,
          "indexpageids" : "",
          "redirects" : "1",
          "pithumbsize": "500"
          ]
        
        
        Alamofire.request(wikipediaURl, method: .get, parameters: parameters).responseJSON{(response) in
            if response.result.isSuccess {
                print(response)
                
                let flowerJSON : JSON = JSON(response.result.value!)
                let pageID = flowerJSON["query"]["pageids"][0].stringValue
                let description = flowerJSON["query"]["pages"][pageID]["extract"].stringValue
                let imageURL = flowerJSON["query"]["pages"][pageID]["thumbnail"]["source"].stringValue
                
                self.imageDescription.text = description
                self.pickedImageView.sd_setImage(with: URL(string: imageURL))
                
            }
        }
        
        
        
    }

}

