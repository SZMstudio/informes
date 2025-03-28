import SwiftUI

struct HoursView: View {
    @State private var hoursText: String = ""
    @State private var workingHours: [WorkingHours] = []
    @State private var isEditing: Bool = false
    @State private var editingIndex: Int?
    @FocusState private var isTextFieldFocused: Bool

    var body: some View {
        NavigationStack {
            VStack {
                TextField("Ingrese horas y minutos (H,MM)", text: $hoursText)
                    .keyboardType(.decimalPad)
                    .padding()
                    .background(Colors.backgroundColor)
                    .cornerRadius(8)
                    .padding(.horizontal)
                    .font(.system(size: 18, weight: .medium))
                    .focused($isTextFieldFocused)
                    .onSubmit {
                        dismissKeyboard()
                    }

                HStack {
                    Button(action: {
                        addHours()
                        dismissKeyboard()
                    }) {
                        Text(isEditing ? "Actualizar Horas" : "Agregar Horas")
                            .foregroundColor(Colors.buttonTextColor)
                            .padding()
                            .background(Colors.buttonColor)
                            .cornerRadius(8)
                            .font(.system(size: 18, weight: .bold))
                    }
                    .padding()
                    
                    NavigationLink(destination: TotalsView(totalHours: totalHoursForCurrentMonth())) {
                        Text("Totales")
                            .foregroundColor(Colors.buttonTextColor)
                            .padding()
                            .background(Colors.buttonColor)
                            .cornerRadius(8)
                            .font(.system(size: 18, weight: .bold))
                    }
                    .padding()
                }

                List {
                    ForEach(workingHours.indices, id: \.self) { index in
                        HStack {
                            Text(workingHours[index].date, formatter: dateFormatter)
                                .font(.system(size: 16, weight: .medium))
                            Spacer()
                            Text(formatHoursAndMinutes(workingHours[index].hours))
                                .font(.system(size: 16, weight: .medium))
                        }
                        .padding(.vertical, 5)
                        .swipeActions(edge: .trailing) {
                            Button(role: .destructive) {
                                deleteItem(at: index)
                            } label: {
                                Label("Borrar", systemImage: "trash")
                            }
                        }
                        .swipeActions(edge: .leading) {
                            Button {
                                startEditing(at: index)
                                isTextFieldFocused = true
                            } label: {
                                Label("Editar", systemImage: "pencil")
                            }
                            .tint(Colors.secondaryColor)
                        }
                    }
                    .onMove(perform: moveItems)
                }

                // Recuadro para el total de horas del mes actual
                VStack {
                    Text("TOTAL")
                        .font(.system(size: 18, weight: .bold))
                        .padding()
                        .background(Color(hex: "e9edc9"))
                        .cornerRadius(8)
                        .padding(.horizontal)

                    Text(formatHoursAndMinutes(totalHoursForCurrentMonth()))
                        .font(.system(size: 16, weight: .medium))
                        .padding(.bottom)
                    
                    // Cálculo de horas restantes para llegar a 50
                    let remainingHours = max(50 - totalHoursForCurrentMonth(), 0)
                    Text("Faltan \(formatHoursAndMinutes(remainingHours)) horas para llegar a 50")
                        .font(.system(size: 16, weight: .medium))
                        .padding(.bottom)
                }
            }
            .padding()
            .background(Colors.backgroundColor)
        }
    }

    private func addHours() {
        guard !hoursText.isEmpty, let hours = convertToDecimalHours(hoursText) else {
            // Manejar entrada inválida
            return
        }

        if let editingIndex = editingIndex {
            workingHours[editingIndex].hours = hours
            self.editingIndex = nil
            self.isEditing = false
        } else {
            let newEntry = WorkingHours(date: Date(), hours: hours)
            workingHours.append(newEntry)
        }
        hoursText = ""
    }

    private func convertToDecimalHours(_ timeString: String) -> Double? {
        let components = timeString.split(separator: ",")
        guard let hours = Double(components[0]) else {
            return nil
        }

        if components.count == 1 {
            // Solo se introdujo la hora, sin minutos
            return hours
        }

        guard let minutes = Double(components[1]), minutes >= 0 && minutes < 60 else {
            return nil
        }
        // Convertir los minutos a horas decimales
        let decimalMinutes = minutes / 60.0
        return hours + decimalMinutes
    }

    private func formatHoursAndMinutes(_ hours: Double) -> String {
        let totalMinutes = Int(hours * 60)
        let hours = totalMinutes / 60
        let minutes = totalMinutes % 60
        return String(format: "%d:%02d", hours, minutes)
    }

    private func startEditing(at index: Int) {
        let totalMinutes = Int(workingHours[index].hours * 60)
        let hours = totalMinutes / 60
        let minutes = totalMinutes % 60
        self.hoursText = String(format: "%d,%02d", hours, minutes)
        self.isEditing = true
        self.editingIndex = index
    }

    private func deleteItem(at index: Int) {
        workingHours.remove(at: index)
    }

    private func moveItems(from source: IndexSet, to destination: Int) {
        workingHours.move(fromOffsets: source, toOffset: destination)
    }

    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "es_ES")
        formatter.dateStyle = .medium
        return formatter
    }

    private func totalHoursForCurrentMonth() -> Double {
        let calendar = Calendar.current
        let currentMonth = calendar.component(.month, from: Date())
        let currentYear = calendar.component(.year, from: Date())

        return workingHours.filter { entry in
            let entryMonth = calendar.component(.month, from: entry.date)
            let entryYear = calendar.component(.year, from: entry.date)
            return entryMonth == currentMonth && entryYear == currentYear
        }.reduce(0) { $0 + $1.hours }
    }
}

extension View {
    func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct HoursView_Previews: PreviewProvider {
    static var previews: some View {
        HoursView()
    }
}
