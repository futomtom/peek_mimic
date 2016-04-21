
import Foundation

struct Kitten {
    let imageURL: NSURL
}

class KittensCreation {
    
    let numberOfKittensToFetch: Int
    let sizeOfKittensImages: Int
    
    init(count: Int, imageSize: Int) {
        self.numberOfKittensToFetch = count
        self.sizeOfKittensImages = imageSize
    }
   
    func createArrayOfKittens() -> [Kitten] {
        var fileSize = sizeOfKittensImages
        var kittens = [Kitten]()
        for _ in 0..<numberOfKittensToFetch {
            guard let kittenURL = NSURL(string:"https://placekitten.com/g/\(fileSize)/\(fileSize)") else { break }
          //  print("Kitten URL Added: \(kittenURL)")
            kittens.append(Kitten(imageURL: kittenURL))
            fileSize = fileSize + 1
        }
        return kittens
    }
}




        

    
