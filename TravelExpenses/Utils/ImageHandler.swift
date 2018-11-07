//
//  ImageHandler.swift
//  TravelExpenses
//
//  Created by Kasseckert, Nils on 14.09.18.
//  Copyright © 2018 SAP. All rights reserved.
//

import UIKit
import SAPOData
import SAPCommon
import SAPFoundation

class ImageHandler {
    private var sapUrlSession: SAPURLSession!
    private var baseUrl: URL!
    
    //MARK: - Singelton
    static var imageHandler: ImageHandler!
    static func createInstance(sapUrlSession: SAPURLSession, baseUrl: URL) {
        imageHandler = ImageHandler()
        imageHandler.sapUrlSession = sapUrlSession
        imageHandler.baseUrl = baseUrl
    }
    
    static func shared() -> ImageHandler {
        return imageHandler
    }
    
    private init() {
        
    }
    
    //MARK: - Image
    public func uploadImages(imageUrls: [URL], completion: @escaping ([String], Error?) -> Void) {
        guard imageUrls.count > 0 else {
            completion([], nil)
            return
        }
        
        let singleUrl = imageUrls[0]
        guard let image = UIImage(contentsOfFile: singleUrl.path),
            let imageData = image.jpegData(compressionQuality: 0.5) else {
            // Should never happen
            completion([], nil)
            
            return
        }
        
        var uploadedImageNames = [String]()
        let imageNameWithoutExtension = getUniqiueImageName()
        
        let uploadURL = baseUrl.appendingPathComponent("blob/ExpenseItemAttachments")
        var urlComponents = URLComponents(url: uploadURL, resolvingAgainstBaseURL: false)!
        urlComponents.queryItems = [URLQueryItem(name: "name", value: imageNameWithoutExtension)]
        
        
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = "POST"
        request.setValue("\(imageData.count)", forHTTPHeaderField: "Content-Length")
        request.addValue("image/jpeg", forHTTPHeaderField: "Content-Type")
        
        self.sapUrlSession.uploadTask(with: request, from: imageData, completionHandler: { _, _, error in
            if let error = error {
                completion([], error)
                
                return
            }
            
            self.saveImageFrom(imageData: imageData, imageName: "\(imageNameWithoutExtension).jpg")
            uploadedImageNames.append(imageNameWithoutExtension)
            
            if imageUrls.count > 1 { //There are additional images to upload
                self.uploadImages(imageUrls: Array(imageUrls.dropFirst()), completion: { (imageNames, error) in
                    if let error = error {
                        completion([], error)
                        
                        return
                    }
                    
                    uploadedImageNames.append(contentsOf: imageNames)
                    
                    completion(uploadedImageNames, nil)
                })
            } else {
                completion(uploadedImageNames, nil)
            }
        }).resume()
    }
    
    public func saveImageFrom(imageData: Data, imageName: String) {
        let filename = getDocumentsDirectory().appendingPathComponent(imageName)
        try? imageData.write(to: filename)
    }
    
    public func getImageWith(imageName: String, completion: @escaping (UIImage?, Error?) -> Void) {
         let filename = getDocumentsDirectory().appendingPathComponent(imageName)
        
        if FileManager.default.fileExists(atPath: filename.path) {
            do {
                let image = try UIImage(data: Data(contentsOf: filename), scale: UIScreen.main.scale)
                
                 completion(image, nil)
            } catch (let error) {
                completion(nil, error)
            }
        } else {
            let uploadURL = baseUrl.appendingPathComponent("blob/ExpenseItemAttachments")
            var urlComponents = URLComponents(url: uploadURL, resolvingAgainstBaseURL: false)!
            urlComponents.queryItems = [URLQueryItem(name: "name", value: imageName.replacingOccurrences(of: ".jpg", with: ""))]
            
            self.sapUrlSession.dataTask(with: urlComponents.url!) { (data, _, error) in
                if let error = error {
                    completion(nil, error)
                    
                    return
                }
                let image = UIImage(data: data!, scale: UIScreen.main.scale)
                
                self.saveImageFrom(imageData: data!, imageName: imageName)
                
                completion(image, nil)
            }.resume()
        }
        
       
    }
    
    //MARK: - Helper
    public func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    private func getUniqiueImageName() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd-HH-mm-ss-SSSS"
        
        return dateFormatter.string(from: Date())
    }
}
