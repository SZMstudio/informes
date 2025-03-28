import SwiftUI

struct MonthlyTotalsView: View {
    var monthlyTotals: [Double]

    var body: some View {
        VStack {
            List {
                ForEach(0..<12) { index in
                    HStack {
                        Text(monthName(for: index))
                        Spacer()
                        Text(formatHoursAndMinutes(monthlyTotals[index]))
                    }
                }
            }

            Spacer()

            HStack {
                Button(action: {
                    // Acción para volver a la pantalla anterior
                }) {
                    Text("Volver")
                        .foregroundColor(Colors.buttonTextColor)
                        .padding()
                        .background(Colors.buttonColor)
                        .cornerRadius(8)
                        .font(.system(size: 18, weight: .bold))
                }
                .padding()

                Button(action: {
                    // Acción para ir a la página de inicio
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
        }
        .padding()
        .background(Colors.backgroundColor)
    }

    private func monthName(for index: Int) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "es_ES")
        return dateFormatter.monthSymbols[(index + 8) % 12]
    }

    private func formatHoursAndMinutes(_ hours: Double) -> String {
        let totalMinutes = Int(hours * 60)
        let hours = totalMinutes / 60
        let minutes = totalMinutes % 60
        return String(format: "%d:%02d", hours, minutes)
    }
}

struct MonthlyTotalsView_Previews: PreviewProvider {
    static var previews: some View {
        MonthlyTotalsView(monthlyTotals: Array(repeating: 0, count: 12))
    }
}
