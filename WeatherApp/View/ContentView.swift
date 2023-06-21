//
//  ContentView.swift
//  WeatherApp
//
//  Created by Mert ATK on 19.06.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var city = ""
    @State private var weatherData: WeatherData?
    @State private var isLoanding = false
    
    private var weatherService = WeatherService()
    
    var body: some View {
        ZStack{
            Rectangle()
                .fill(Gradient(colors: [.yellow, .indigo]))
                    .ignoresSafeArea()
            VStack{
                Image("atk")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 200, height: 200)
                    
                TextField("Şehirinizi giriniz", text: $city)
                    .font(.subheadline)
                    .padding(12)
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    .padding(.horizontal,22)
                Button{
                    getWeatherData()
                }label:{
                    Text("Göster")
                        .padding()
                        .frame(width: 280, height: 50)
                        .background(Color.yellow)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        
                }.padding()

                if isLoanding{
                    LoadingIndicatorView()
                } else if let weatherData = weatherData {
                    VStack{
                        Text(weatherData.name)
                            .font(.system(size:22))
                            .foregroundColor(.white)
                            .bold()
                        VStack(alignment: .leading){
                            HStack{
                                Image(systemName: "thermometer.sun.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 50, height: 50)
                                    .foregroundColor(.white)
                                    .padding(.horizontal,10)
                                let celsiusTemperature = Int(weatherData.main.temp - 273.15)
                                Text("Sıcaklık: \(celsiusTemperature)°C")
                                    .font(.system(size:30))
                                
                            }
                            HStack{
                                Image(systemName: "humidity")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 50, height: 50)
                                    .foregroundColor(.white)
                                    .padding(.horizontal,10)
                                Text("Nem : \(Int(weatherData.main.humidity))%")
                                    .font(.system(size:30))
                                
                            }
                        }
                        
                    }
                    
                }
             Spacer()
                
            }
        }
        
    }
    private func getWeatherData() {
        isLoanding = true
        

        weatherService.getWeatherData(for: city) { result in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                isLoanding = false
                
                switch result{
                case .success(let weatherData):
                    self.weatherData = weatherData
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
        
}





struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
