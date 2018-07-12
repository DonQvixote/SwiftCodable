//
//  LuggageTagScanner.swift
//  LuggageScanner
//
//  Created by 夏语诚 on 2018/7/11.
//  Copyright © 2018年 Banana. All rights reserved.
//

import UIKit
import CoreData
import CoreImage

class LuggageTagScanner {
    private lazy var detector: CIDetector? = {
        let context = CIContext()
        let options = [CIDetectorAccuracy: CIDetectorAccuracyHigh]
        // 使用 CIDetector 解析静态图片二维码，也可以用 AVFoundation 框架通过摄像头实时识别
        let detector = CIDetector(ofType: CIDetectorTypeQRCode, context: context, options: options)
        return detector
    }()
    
    enum Point {
        case origin, destination
    }
    
    func scan(image uiImage: UIImage, at point: Point, in context: NSManagedObjectContext) throws {
        guard
            let ciImage = CIImage(image: uiImage),
            let features = detector?.features(in: ciImage),
            let qrCode = features.first as? CIQRCodeFeature,
            let data = qrCode.messageString?.data(using: .utf8) else {
                return
        }
        
        let decoder = JSONDecoder()
        decoder.userInfo[.context] = context
        
        let luggage = try decoder.decode(Luggage.self, from: data)
        
        switch point {
        case .origin:
            luggage.departedAt = NSDate()
        case .destination:
            luggage.arrivedAt = NSDate()
        }
    }
}
