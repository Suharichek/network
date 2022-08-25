//
//  PhotosArray.swift
//  Navigation
//
//  Created by Suharik on 24.06.2022.
//

import UIKit
import SnapKit
import iOSIntPackage

private let filtersSet: [ColorFilter] = [.colorInvert, .noir, .chrome, .fade, .posterize, .tonal,
                                         .process, .transfer, .bloom(intensity: 10),
                                         .sepia(intensity: 80)]
private let photosArray = (1...20).compactMap {"\($0)"}
private let imageProcessor = ImageProcessor()
public var filtredPhotosArray:[UIImage] = []

public func createPhotosArray() {
    for i in photosArray {
        guard let pic = UIImage(named: i) else { return }
        filtredPhotosArray.append(makeFiltredImage(pic))
    }
}

func makeFiltredImage(_ image: UIImage) -> UIImage {
    var newImage = UIImage()
    imageProcessor.processImage(sourceImage: image, filter: getRandomFilter(set: filtersSet)) { filteredImage in
        newImage = filteredImage ?? UIImage()
    }
    return newImage
}

func getRandomFilter (set: [ColorFilter]) -> ColorFilter {
    let randomFilterNumber = Int.random(in: 0..<set.count)
    return set[randomFilterNumber]
}

