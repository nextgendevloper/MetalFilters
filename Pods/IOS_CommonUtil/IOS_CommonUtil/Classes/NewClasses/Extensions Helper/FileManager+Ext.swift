//
//  FileManager+Ext.swift
//  IOS_CommonUtil
//
//  Created by Developer on 7/15/21.
//

import UIKit

extension FileManager {
    
    public func clearTmpDirectory() {
        do {
            let tmpDirURL = FileManager.default.temporaryDirectory
            let tmpDirectory = try contentsOfDirectory(atPath: tmpDirURL.path)
            try tmpDirectory.forEach { file in
                let fileUrl = tmpDirURL.appendingPathComponent(file)
                try removeItem(atPath: fileUrl.path)
            }
        } catch {
           //catch the error somehow
        }
    }
    
    public func clearFile(url:URL) {
        do {
        let documentsURL = urls(for: .documentDirectory, in: .userDomainMask)[0]
            _ = try contentsOfDirectory(atPath: documentsURL.path)
            try removeItem(atPath: url.path)
            print("removed video" , url.absoluteURL)
        } catch {
            
        }
    }
    public func removeItemIfExisted(_ url:URL) -> Void {
        if FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.removeItem(atPath: url.path)
            }
            catch {
                print("Failed to delete file")
            }
        }
    }
    
    public func  getCopyOfCurrent(video url : URL) -> URL? {
    
                   let tempDirectoryURL = URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true)

                   // Create a destination URL.
        let targetURL = tempDirectoryURL.appendingPathComponent(UUID().uuidString).appendingPathExtension(url.lastPathComponent)

                   // Copy the file.
                   do {
                       try FileManager.default.copyItem(at: url, to: targetURL)
                       return targetURL
                   } catch let error {
                       print("Unable to copy file: \(error)")
                    return nil
                   }
    }

    // get directory folder
    // add UIImage
    // delete directory folder
    
    public func createDirectory(_directoyName : String = "SavedImages") -> Bool {

       let fileManager = FileManager.default
              
              let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(_directoyName)
              
              if !fileManager.fileExists(atPath:paths){
                  do{
                      try? fileManager.createDirectory(atPath: paths, withIntermediateDirectories: true, attributes: nil)
                  }
              }else{
                   print("Already dictionary created.")
              }
              return true
   }
    public func getDirectoryPath(_ image : UIImage)->URL{
        let time = NSDate().timeIntervalSince1970
        let newName = "\(time)"
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let directoryBasePath = path.appendingPathComponent("SavedImages")
        return directoryBasePath.appendingPathComponent(newName)
        
    }
    
    public func saveImageToDirectory(image:UIImage) -> String? {
     
        let isFileFolderCreated:Bool = createDirectory()
        
        if (isFileFolderCreated) {
        
        let destinationURL = getDirectoryPath(image)
            
            if let data = image.jpegData(compressionQuality: 1.0) {
                do {
                    try data.write(to: destinationURL)
                    return "\(destinationURL)"
                } catch {
                    print("error saving file to documents:", error)
                    return nil
                }
            }
            
        
    }
        return nil
    }
    public func deleteDirectory(_directoyName : String = "SavedImages"){
               
               

        do {
            let path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(_directoyName)
           
            let directory = try contentsOfDirectory(atPath: path)

             directory.forEach { file in
                let fileUrl = path.appending("/"+file)
                do {
                try removeItem(atPath: fileUrl)
                } catch {
                    print("Image Not available")
                }
            }
        } catch {
            print("An error took place: \(error)")
        }
    }
    public func getImageFromDirectory(imagePath:String , fromDirectory : String = "SavedImages") -> UIImage? {

        let array: [AnyHashable] = imagePath.components(separatedBy: "/")
               let imageName: String = array.last as! String
               
               let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
               let url = NSURL(fileURLWithPath: paths[0]).appendingPathComponent(fromDirectory)
               guard let pathComponent = url?.appendingPathComponent(imageName) else {return nil}
               let filePath = pathComponent.path
               
               let fileManager = FileManager.default
               if fileManager.fileExists(atPath: filePath) {
                   guard let dataFromPath = NSData(contentsOfFile:filePath) else {return nil}
                   guard let image = UIImage(data: dataFromPath as Data) else {return nil}
                   return image
               }
               return nil
       }
}

