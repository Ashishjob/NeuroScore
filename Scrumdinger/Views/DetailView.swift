import SwiftUI

struct DetailView: View {
    @Binding var scrum: DailyScrum
    @State private var editingScrum = DailyScrum.emptyScrum
    @State private var isPresentingEditView = false

    var body: some View {
        List {
            Section(header: Text("Log Info")) {
                NavigationLink(destination: MeetingView(scrum: $scrum)) {
                    Label("Start Recording", systemImage: "timer")
                        .font(.headline)
                        .foregroundColor(.accentColor)
                }
            }

            Section(header: Text("GCS Scores")) {
                HStack {
                    Text("Vision:")
                    Spacer()
                    Text("\(scrum.gcsVision)")
                }
                HStack {
                    Text("Verbal:")
                    Spacer()
                    Text("\(scrum.gcsVerbal)")
                }
                HStack {
                    Text("Motor:")
                    Spacer()
                    Text("\(scrum.gcsMotor)")
                }
                HStack {
                    Text("Total GCS:")
                    Spacer()
                    Text("\(scrum.totalGcs)")
                }
            }

            Section(header: Text("History")) {
                if scrum.history.isEmpty {
                    Label("No transcriptions yet", systemImage: "calendar.badge.exclamationmark")
                }
                ForEach(scrum.history) { history in
                    NavigationLink(destination: HistoryView(history: history)) {
                        HStack {
                            Image(systemName: "calendar")
                            Text(history.date, style: .date)
                        }
                    }
                }
                
            }
            VStack {
                HStack {
                    Text("Side Note:")
                    Spacer()
                }
                Spacer()
                HStack {
                    Text("\(scrum.sideNote)")
                        .foregroundColor(.secondary)
                    Spacer()
                }
                
                .padding(.bottom, 10)
            }
            .padding(.top, 10)
        }
        .navigationTitle(scrum.title)
        .sheet(isPresented: $isPresentingEditView) {
            NavigationStack {
                DetailEditView(scrum: $scrum)
                    .navigationTitle(scrum.title)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                isPresentingEditView = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done") {
                                isPresentingEditView = false
                                scrum = editingScrum
                            }
                        }
                    }
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            DetailView(scrum: .constant(DailyScrum.sampleData[0]))
        }
    }
}
