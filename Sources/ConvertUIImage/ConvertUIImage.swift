// The Swift Programming Language
// https://docs.swift.org/swift-book

#if os(iOS)
import UIKit
import CoreVideo

public func convertImageToPixelBuffer(image: UIImage, imageWidth: Int, imageHeight: Int) -> CVPixelBuffer? {
    let targetSize = CGSize(width: imageWidth, height: imageHeight)
    
    // Create a graphics context with the target size
    UIGraphicsBeginImageContextWithOptions(targetSize, true, 1.0)
    image.draw(in: CGRect(origin: .zero, size: targetSize))
    
    // Get the resized image from the context
    guard let resizedImage = UIGraphicsGetImageFromCurrentImageContext() else {
        UIGraphicsEndImageContext()
        return nil
    }
    
    UIGraphicsEndImageContext()
    
    // Create pixel buffer attributes
    let attributes: [CFString: Any] = [
        kCVPixelBufferCGImageCompatibilityKey: true,
        kCVPixelBufferCGBitmapContextCompatibilityKey: true
    ]
    
    var pixelBuffer: CVPixelBuffer?
    let status = CVPixelBufferCreate(
        kCFAllocatorDefault,
        Int(targetSize.width),
        Int(targetSize.height),
        kCVPixelFormatType_32BGRA,
        attributes as CFDictionary,
        &pixelBuffer
    )
    
    guard status == kCVReturnSuccess, let buffer = pixelBuffer else {
        return nil
    }
    
    // Lock the pixel buffer to modify its memory
    CVPixelBufferLockBaseAddress(buffer, .readOnly)
    
    // Create a bitmap context to draw the image
    guard let context = CGContext(
        data: CVPixelBufferGetBaseAddress(buffer),
        width: Int(targetSize.width),
        height: Int(targetSize.height),
        bitsPerComponent: 8,
        bytesPerRow: CVPixelBufferGetBytesPerRow(buffer),
        space: CGColorSpaceCreateDeviceRGB(),
        bitmapInfo: CGImageAlphaInfo.premultipliedFirst.rawValue
    ) else {
        CVPixelBufferUnlockBaseAddress(buffer, .readOnly)
        return nil
    }
    
    // Draw the image into the context
    guard let cgImage = resizedImage.cgImage else {
        CVPixelBufferUnlockBaseAddress(buffer, .readOnly)
        return nil
    }
    context.draw(cgImage, in: CGRect(origin: .zero, size: targetSize))
    
    CVPixelBufferUnlockBaseAddress(buffer, .readOnly)
    return buffer
}
#endif
