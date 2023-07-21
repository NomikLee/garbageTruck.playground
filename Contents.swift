import UIKit
import MapKit
import AVFAudio
import AVFoundation
import SafariServices
import PlaygroundSupport


struct CreateTruckAndPeopleCoordinate {
    var truckLatitude = 0.0, truckLongitude = 0.0
    var peopleLatitude = 0.0, peopleLongitude = 0.0
  
}

func distanceConversion(pLa peopleLatitude: Double,pLo peopleLongitude: Double,tLa truckLatitude: Double,tLo truckLongitude: Double) -> String {
    
    let conversion = sqrt(pow(peopleLatitude - truckLatitude, 2) + pow(peopleLongitude - truckLongitude, 2)) * 1000
    
    return String(format: "%.1f", conversion)
}



let peopleCoordinate1 = CreateTruckAndPeopleCoordinate(peopleLatitude: 25.04886, peopleLongitude: 121.45409)

let truckCoordinate1 = CreateTruckAndPeopleCoordinate(truckLatitude: 25.047902, truckLongitude: 121.452562)

var conversionInput = distanceConversion(pLa: peopleCoordinate1.peopleLatitude, pLo: peopleCoordinate1.peopleLongitude, tLa: truckCoordinate1.truckLatitude, tLo: truckCoordinate1.truckLongitude)

let MapView = MKMapView(frame: CGRect(x: 0, y: 0, width: 500, height: 500))
let people1Point = MKPointAnnotation()
let truck1Point = MKPointAnnotation()

MapView.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: peopleCoordinate1.peopleLatitude, longitude: peopleCoordinate1.peopleLongitude), latitudinalMeters: 1000, longitudinalMeters: 1000)

people1Point.title = "等丟垃圾人員1"
people1Point.coordinate = CLLocationCoordinate2D(latitude: peopleCoordinate1.peopleLatitude, longitude: peopleCoordinate1.peopleLongitude)

truck1Point.title = "垃圾車1"
truck1Point.coordinate = CLLocationCoordinate2D(latitude: truckCoordinate1.truckLatitude, longitude: truckCoordinate1.truckLongitude)

MapView.addAnnotation(people1Point)
MapView.addAnnotation(truck1Point)

//PlaygroundPage.current.liveView = MapView

let TodayNow = Date()
let TodayDateFormatter = DateFormatter()
TodayDateFormatter.dateFormat = "西元yyyy年MM月dd日 HH點mm分"
let TodayDateString = TodayDateFormatter.string(from: TodayNow)

let soundNotify =  AVSpeechUtterance(string: "現在時間\(TodayDateString)垃圾車距離您大約\(conversionInput)公尺")
let NotifySynthesizer = AVSpeechSynthesizer()
soundNotify.voice = AVSpeechSynthesisVoice(language: "zh-TW")
soundNotify.pitchMultiplier = 0.9
soundNotify.rate = 0.6

NotifySynthesizer.speak(soundNotify)

let url = URL(string: "https://drive.google.com/uc?export=download&id=1PklN84VvWzTMH80hzk1Ny2X9aXCUJoTr")
let player = AVPlayer(url: url!)
player.play()


print("現在時間 \(TodayDateString) 垃圾車距離您大約 \(conversionInput) 公尺")

