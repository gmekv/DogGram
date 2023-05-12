//
//  CarouselView.swift
//  DogGram
//
//  Created by Giorgi Meqvabishvili on 04.05.23.
//
import SwiftUI
import SDWebImageSwiftUI

struct CarouselView: View {
    
    @State var dogImageURLs: [URL] = []
    @State var selection: Int = 1
    let maxCount: Int = 8
    @State var timerAdded: Bool = false
    
    var body: some View {
        TabView(selection: $selection,
                content:  {
                    ForEach(0..<maxCount) { index in
                        if index < dogImageURLs.count {
                            WebImage(url: dogImageURLs[index])
                                .resizable()
                                .scaledToFill()
                                .tag(index)
                        } else {
                            ProgressView()
                        }
                    }
                })
            .tabViewStyle(PageTabViewStyle())
            .frame(height: 300)
            .animation(.default)
            .onAppear(perform: {
                if !timerAdded {
                    addTimer()
                    fetchDogImageURLs()
                }
            })
    }
    
    // MARK: FUNCTIONS
    
    func addTimer() {
        timerAdded = true
        let timer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { (timer) in
            if selection == (maxCount - 1) {
                selection = 1
            } else {
                selection += 1
            }
        }
        timer.fire()
    }
    
    func fetchDogImageURLs() {
        let group = DispatchGroup()
        
        for _ in 0..<maxCount {
            group.enter()
            fetchRandomDogImageURL { imageURL in
                if let imageURL = imageURL {
                    DispatchQueue.main.async {
                        dogImageURLs.append(imageURL)
                        group.leave()
                    }
                }
            }
        }
        
        group.notify(queue: .main) {
            // All image URLs have been fetched
        }
    }
    
    func fetchRandomDogImageURL(completion: @escaping (URL?) -> Void) {
        guard let url = URL(string: "https://dog.ceo/api/breeds/image/random") else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                if let dogData = try? JSONDecoder().decode(DogData.self, from: data) {
                    if let imageURL = URL(string: dogData.message) {
                        completion(imageURL)
                    } else {
                        completion(nil)
                    }
                }
            }
        }.resume()
    }
}

struct CarouselView_Previews: PreviewProvider {
    static var previews: some View {
        CarouselView()
            .previewLayout(.sizeThatFits)
    }
}

struct DogData: Codable {
    let message: String
    let status: String
}
