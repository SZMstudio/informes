import SwiftUI

struct TotalsView: View {
    var totalHours: Double
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            List {
                HStack {
                    Text("Horas restantes hasta 50 (mes actual):")
                    Spacer()
                    Text(formatHoursAndMinutes(max(50 - totalHours, 0)))
                }
                HStack {
                    Text("Horas restantes hasta 600:")
                    Spacer()
                    Text(formatHoursAndMinutes(max(600 - totalHours, 0)))
                }
            }

            Spacer()

            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Inicio")
                    .foregroundColor(Colors.buttonTextColor)
                    .padding()
                    .background(Colors.buttonColor)
                    .cornerRadius(8)
                    .font(.system(size: 18, weight: .bold))
            }
            .padding()
        }
        .padding()
        .background(Colors.backgroundColor)
        .navigationBarBackButtonHidden(true) // Esto elimina el botón "< Back"
    }

    private func formatHoursAndMinutes(_ hours: Double) -> String {
        let totalMinutes = Int(hours * 60)
        let hours = totalMinutes / 60
        let minutes = totalMinutes % 60
        return String(format: "%d:%02d", hours, minutes)
    }
}

struct TotalsView_Previews: PreviewProvider {
    static var previews: some View {
        TotalsView(totalHours: 0)
    }
}
