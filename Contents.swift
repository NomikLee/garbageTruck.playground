// 引入必要的框架
import UIKit
import MapKit
import AVFAudio
import AVFoundation
import SafariServices
import PlaygroundSupport

// 定義一個結構來保存垃圾車和人員的座標資訊
struct CreateTruckAndPeopleCoordinate {
    var truckLatitude = 0.0, truckLongitude = 0.0 // 垃圾車的緯度和經度
    var peopleLatitude = 0.0, peopleLongitude = 0.0 // 人員的緯度和經度
}

// 計算兩個座標之間的距離
func distanceConversion(pLa peopleLatitude: Double, pLo peopleLongitude: Double, tLa truckLatitude: Double, tLo truckLongitude: Double) -> String {
    let conversion = sqrt(pow(peopleLatitude - truckLatitude, 2) + pow(peopleLongitude - truckLongitude, 2)) * 1000
    return String(format: "%.1f", conversion) // 將計算結果格式化為字串並返回
}

// 建立人員和垃圾車的座標資訊
let peopleCoordinate1 = CreateTruckAndPeopleCoordinate(peopleLatitude: 25.04886, peopleLongitude: 121.45409) // 人員座標
let truckCoordinate1 = CreateTruckAndPeopleCoordinate(truckLatitude: 25.047902, truckLongitude: 121.452562) // 垃圾車座標

// 計算垃圾車和人員之間的距離
var conversionInput = distanceConversion(pLa: peopleCoordinate1.peopleLatitude, pLo: peopleCoordinate1.peopleLongitude, tLa: truckCoordinate1.truckLatitude, tLo: truckCoordinate1.truckLongitude)

// 創建一個MKMapView實例，用於顯示地圖
let MapView = MKMapView(frame: CGRect(x: 0, y: 0, width: 500, height: 500))

// 創建MKPointAnnotation實例來標記人員和垃圾車的位置
let people1Point = MKPointAnnotation()
let truck1Point = MKPointAnnotation()

// 設定地圖的顯示區域為人員位置周圍的一個正方形範圍
MapView.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: peopleCoordinate1.peopleLatitude, longitude: peopleCoordinate1.peopleLongitude), latitudinalMeters: 1000, longitudinalMeters: 1000)

// 設定人員和垃圾車的標題和座標
people1Point.title = "等丟垃圾人員1"
people1Point.coordinate = CLLocationCoordinate2D(latitude: peopleCoordinate1.peopleLatitude, longitude: peopleCoordinate1.peopleLongitude)
truck1Point.title = "垃圾車1"
truck1Point.coordinate = CLLocationCoordinate2D(latitude: truckCoordinate1.truckLatitude, longitude: truckCoordinate1.truckLongitude)

// 將標記加入地圖
MapView.addAnnotation(people1Point)
MapView.addAnnotation(truck1Point)

PlaygroundPage.current.liveView = MapView

// 設定AVSpeechUtterance來準備音頻通知內容
let TodayNow = Date()
let TodayDateFormatter = DateFormatter()
TodayDateFormatter.dateFormat = "西元yyyy年MM月dd日 HH點mm分"

let TodayDateString = TodayDateFormatter.string(from: TodayNow)
let soundNotify =  AVSpeechUtterance(string: "現在時間\(TodayDateString)垃圾車距離您大約\(conversionInput)公尺")
let NotifySynthesizer = AVSpeechSynthesizer()
soundNotify.voice = AVSpeechSynthesisVoice(language: "zh-TW") // 設定通知語音的語言為中文
soundNotify.pitchMultiplier = 0.9 // 設定通知語音的音調
soundNotify.rate = 0.6 // 設定通知語音的速率

// 系統語音講話
NotifySynthesizer.speak(soundNotify)

// 播放垃圾車駛來的音樂
let url = URL(string: "https://drive.google.com/uc?export=download&id=1PklN84VvWzTMH80hzk1Ny2X9aXCUJoTr")
let player = AVPlayer(url: url!)
player.play()

// 列印出垃圾車和人員之間的距離和現在的時間
print("現在時間 \(TodayDateString) 垃圾車距離您大約 \(conversionInput) 公尺")
