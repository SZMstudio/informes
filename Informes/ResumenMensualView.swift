import SwiftUI
import CoreData

struct ResumenMensualView: View {
    @FetchRequest(
        entity: Predicacion.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Predicacion.fecha, ascending: true)],
        predicate: NSPredicate(format: "fecha >= %@ AND fecha < %@", argumentArray: [Date().startOfMonth(), Date().endOfMonth()])
    ) var predicaciones: FetchedResults<Predicacion>

    var body: some View {
        VStack {
            Text("Resumen Mensual")
                .font(.largeTitle)
                .padding()
            
            List {
                ForEach(predicaciones) { predicacion in
                    Text("\(predicacion.fecha!, formatter: dateFormatter): \(predicacion.horas) horas")
                }
            }
            
            Text("Total de horas: \(totalHoras())")
                .font(.headline)
                .padding()
        }
        .padding()
    }
    
    func totalHoras() -> Double {
        predicaciones.reduce(0) { $0 + $1.horas }
    }
}

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    return formatter
}()
