import SwiftUI

struct ContentView: View {
    @State private var showIntakeForm = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Image(systemName: "figure.run")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .foregroundColor(.blue)
                
                Text("SMPLv1")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("Your personal AI fitness coach")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Spacer().frame(height: 30)
                
                Button(action: {
                    showIntakeForm = true
                }) {
                    Text("Get Started")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(width: 220, height: 50)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                
                Spacer()
            }
            .padding()
            .navigationBarHidden(true)
            .fullScreenCover(isPresented: $showIntakeForm) {
                IntakeFormWrapper()
            }
        }
    }
}

struct IntakeFormWrapper: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            IntakeForm()
                .navigationBarTitle("Profile Setup", displayMode: .inline)
                .navigationBarItems(leading: Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Cancel")
                })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
} 