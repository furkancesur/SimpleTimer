import SwiftUI

struct ContentView: View {
    @State private var hours = 0
    @State private var minutes = 0
    @State private var seconds = 0
    @State private var isActive = false
    @State private var timeRemaining: Int = 0
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        NavigationView {
            VStack {
                Text(timeString(time: timeRemaining))
                    .font(.system(size: 80, weight: .bold, design: .rounded))
                    .padding()
                
                HStack {
                    Picker("Hours", selection: $hours) {
                        ForEach(0..<24) { hour in
                            Text("\(hour) hour\(hour == 1 ? "" : "s")")
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    
                    Picker("Minutes", selection: $minutes) {
                        ForEach(0..<60) { minute in
                            Text("\(minute) min")
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    
                    Picker("Seconds", selection: $seconds) {
                        ForEach(0..<60) { second in
                            Text("\(second) sec")
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                }
                .padding()
                
                HStack {
                    Button(action: {
                        if !isActive {
                            timeRemaining = hours * 3600 + minutes * 60 + seconds
                        }
                        isActive.toggle()
                    }) {
                        Text(isActive ? "Pause" : "Start")
                            .font(.title)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    
                    Button(action: {
                        hours = 0
                        minutes = 0
                        seconds = 0
                        timeRemaining = 0
                        isActive = false
                    }) {
                        Text("Reset")
                            .font(.title)
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
            }
            .navigationTitle("Simple Timer")
        }
        .onReceive(timer) { _ in
            guard isActive else { return }
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                isActive = false
            }
        }
    }
    
    func timeString(time: Int) -> String {
        let hours = time / 3600
        let minutes = (time % 3600) / 60
        let seconds = time % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
