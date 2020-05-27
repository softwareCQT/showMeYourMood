//
//  ImageStore.swift
//  Note
//
//  Created by 峰 on 2020/5/25.
//  Copyright © 2020 峰. All rights reserved.
//

import Foundation

final class ImageStore {
  static func imageURL(imageName: String) -> String?{
      guard imageName.count > 0 else {
          return nil
      }
      let fileManager = FileManager()
      guard let path = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first else {
          print("发生了错误")
          return nil
      }
      let dir = path + "/Image"
      
      print(dir)
      
      if !fileManager.fileExists(atPath: dir) {
          do {
              try fileManager.createDirectory(atPath: dir, withIntermediateDirectories: true, attributes: nil)
          } catch {
              print("文件夹创建失败")
          }
          print("创建了文件夹")
      }
      return dir + "/" + imageName + ".png"
  }
    // 这里最好做一个block回传
    // 存图片，同名会更新
    static func storeImage(data: Data, imageName: String) {
        guard imageName.count > 0 else {
            return
        }
        let fileManager = FileManager()
        guard let path = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first else {
            print("发生了错误")
            return
        }
        let dir = path + "/Image"
        
        print(dir)
        
        if !fileManager.fileExists(atPath: dir) {
            do {
                try fileManager.createDirectory(atPath: dir, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print("文件夹创建失败")
            }
            print("创建了文件夹")
        }
        let filepath = dir + "/" + imageName + ".png"
        fileManager.createFile(atPath: filepath, contents: data, attributes: nil)
    }
    
    static func getImage(imageName: String) -> UIImage? {

        return nil
    }
    
    static func deleteImage(imageName: String) {
        
    }
}
