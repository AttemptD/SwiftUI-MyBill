//
//  ImageTranser.swift
//  MyBill
//
//  Created by Attempt D on 2020/8/13.
//  Copyright © 2020 Frank D. All rights reserved.
//

import Foundation
import UIKit


class ImageTranser {
    func ImageToData(image : UIImage) -> Data{
        let data = image.pngData()
        return data!
       
    }
    
    func DataToImage(data : Data) -> UIImage {
        let uiImage: UIImage = UIImage(data: data)!
        return uiImage
    }

}
