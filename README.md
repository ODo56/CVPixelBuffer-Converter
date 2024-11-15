# ConvertTOCVPixelBuffer

A Swift library that provides an easy-to-use function to convert **UIImage** objects into **CVPixelBuffer**. This is useful for image processing tasks, such as feeding images into Core ML models.

## Features
- Converts **UIImage** to **CVPixelBuffer**.
- Simple and straightforward API.
- For iOS 15.0 and later.

## Requirements
- **iOS**: 15.0 or later
- **Swift**: 6.0 or later

## Installation

### Swift Package Manager
To add `ConvertTOCVPixelBuffer` to your project:

1. In Xcode, go to **File > Add Packages**.
2. Paste the following repository URL into the search bar:  
   `https://github.com/ODo56/ConvertTOCVPixelBuffer`
3. Select the package and click **Add Package**.

## Usage

### Import the Library
Once added to your project, import the library in your Swift file:

```swift
import ConvertUIImage
     if let pixelBuffer = convertImageToPixelBuffer(image: yourImage ?? backupImage, imageWidth: width, imageHeight: height) {
        //your code
}

