import SwiftUI

struct ContentView: View {
    @State private var timeRemaining = 60
    @State private var isActive = false
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()


    var body: some View {
        VStack {
            Text(timeString(time: timeRemaining))
                .font(.system(size: 80, weight: .bold, design: .rounded))
                .padding()
            
            HStack {
                Button(action: {
                    self.isActive.toggle()
                }) {
                    Text(isActive ? "Pause" : "Start")
                        .font(.title)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                Button(action: {
                    self.timeRemaining = 60
                    self.isActive = false
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
        .onReceive(timer) { _ in
            guard self.isActive else { return }
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            } else {
                self.isActive = false
            }
        }
    }
    
    func timeString(time: Int) -> String {
        let minutes = time / 60
        let seconds = time % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
