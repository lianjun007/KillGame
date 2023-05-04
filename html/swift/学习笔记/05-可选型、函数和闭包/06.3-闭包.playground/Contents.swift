// 导入网络请求和JSON解析的库
import Foundation
import SwiftyJSON

// 定义一个结构体来存储天气数据
struct WeatherData {
    var city: String // 城市名
    var temperature: Double // 温度（摄氏度）
    var humidity: Double // 湿度（百分比）
    var windSpeed: Double // 风速（米/秒）
}

// 定义一个函数来从指定的URL获取JSON数据，并返回一个WeatherData对象
func getWeatherData(from url: String) -> WeatherData? {
    // 创建一个URL对象
    guard let url = URL(string: url) else {
        print("Invalid URL")
        return nil
    }
    
    // 创建一个URLSession对象
    let session = URLSession.shared
    
    // 创建一个信号量来同步网络请求
    let semaphore = DispatchSemaphore(value: 0)
    
    // 定义一个变量来存储返回的天气数据
    var weatherData: WeatherData?
    
    // 发起网络请求，并在完成后执行闭包函数
    session.dataTask(with: url) { data, response, error in
        
        // 检查是否有错误或无数据
        if let error = error {
            print("Error:", error.localizedDescription)
            semaphore.signal()
            return
        }
        
        guard let data = data else {
            print("No data")
            semaphore.signal()
            return
        }
        
        // 尝试将数据解析为JSON对象
        do {
            let json = try JSON(data: data)
            
            // 从JSON对象中提取所需的字段，并创建一个WeatherData对象
            
            let city = json["name"].stringValue
            
            let temperature = json["main"]["temp"].doubleValue - 273.15
            
            let humidity = json["main"]["humidity"].doubleValue
            
            let windSpeed = json["wind"]["speed"].doubleValue
            
            weatherData = WeatherData(city: city, temperature: temperature, humidity: humidity, windSpeed: windSpeed)
            
        } catch {
            print("Error:", error.localizedDescription)
        }
        
        // 释放信号量，表示网络请求已完成
        semaphore.signal()
        
    }.resume()
    
    // 等待网络请求完成，或超时（10秒）
    _ = semaphore.wait(timeout: .now() + 10)
    
    // 返回天气数据，如果有的话
    return weatherData
    
}

// 定义一个测试用的URL，使用OpenWeatherMap API（需要注册并获取API密钥）
let testURL = "https://api.openweathermap.org/data/2.5/weather?q=Beijing&appid=YOUR_API_KEY"

// 调用函数，并打印结果
if let weatherData = getWeatherData(from: testURL) {
    
   print("城市：\(weatherData.city)")
   print("温度：\(weatherData.temperature)°C")
   print("湿度：\(weatherData.humidity)%")
   print("风速：\(weatherData.windSpeed)m/s")

} else {

   print("无法获取天气数据")

}
