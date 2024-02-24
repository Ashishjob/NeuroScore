import SwiftUI

struct ScrumsView: View {
    @Environment(\.colorScheme) var colorScheme
    @Binding var scrums: [DailyScrum]
    @Environment(\.scenePhase) private var scenePhase
    @State private var isPresentingNewScrumView = false
    let saveAction: () -> Void
    
    // Key for UserDefaults
    private let scrumsKey = "ScrumsKey"
    
    // Load saved scrums from UserDefaults
    private func loadScrums() {
        if let data = UserDefaults.standard.data(forKey: scrumsKey) {
            do {
                scrums = try JSONDecoder().decode([DailyScrum].self, from: data)
            } catch {
                print("Error decoding scrums: \(error)")
            }
        }
    }
    
    // Save scrums to UserDefaults
    private func saveScrums() {
        do {
            let data = try JSONEncoder().encode(scrums)
            UserDefaults.standard.set(data, forKey: scrumsKey)
        } catch {
            print("Error encoding scrums: \(error)")
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                if scrums.isEmpty {
                    Text("Add a new Scrum to get started!")
                        .foregroundColor(.secondary)
                        .padding()
                    
                    Spacer()
                    Text("Here's a quick guide to help you understand how the tool works!")
                        .foregroundColor(.secondary)
                        .padding(.leading, 20)
                    HStack {
                        VStack {
                            HStack {
                                Image(systemName: "info.circle")
                                    .foregroundColor(.blue)
                                    .accessibilityLabel("Information")
                                Text("Click on the information circle on the top left to find out more about what the GCS really is.")
                                    .foregroundColor(.secondary)
                                    .padding(.leading, 5)
                            }
                            .padding()
                            HStack {
                                Image(systemName: "plus")
                                    .foregroundColor(.blue)
                                    .accessibilityLabel("New Scrum")
                                Text("Click on the plus button on the top right to add a new log for the GCS scores of that day.")
                                    .foregroundColor(.secondary)
                                    .padding(.leading, 5)
                            }
                            .padding()
                            HStack {
                                Image(systemName: "square.and.arrow.down")
                                    .foregroundColor(.blue)
                                    .accessibilityLabel("Download CSV")
                                Text("Click on the button below to download all of the GCS logs in a CSV file.")
                                    .foregroundColor(.secondary)
                                    .padding(.leading, 5)
                            }
                            .padding()
                            Spacer()
                        }
                        Spacer()
                    }
                    .padding(.leading, 10)
                } else {
                    List {
                        ForEach(scrums.indices.reversed(), id: \.self) { index in
                            let scrum = scrums[index]
                            NavigationLink(destination: DetailView(scrum: $scrums[index])) {
                                CardView(scrum: scrum)
                            }
                            .listRowBackground(scrum.theme.mainColor)
                        }
                    }
                    Spacer()
                }
                
                Button(action: {
                    DailyScrum.generateAndSaveCSV()
                }) {
                    Label("Download CSV", systemImage: "square.and.arrow.down")
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10).foregroundColor(.blue))
                        .foregroundColor(.white)
                }
                .accessibilityLabel("Download CSV")
                .padding(.bottom, 20)
            }
            .navigationTitle("GCS Scores")
            .onAppear {
                // Load scrums when the view appears
                loadScrums()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    NavigationLink(destination: InformationView()) {
                        Image(systemName: "info.circle")
                    }
                    .accessibilityLabel("Information")
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isPresentingNewScrumView = true
                    }) {
                        Image(systemName: "plus")
                    }
                    .accessibilityLabel("New Scrum")
                }
            }
        }
        .sheet(isPresented: $isPresentingNewScrumView) {
            NewScrumSheet(scrums: $scrums, isPresentingNewScrumView: $isPresentingNewScrumView)
        }
        .onChange(of: scenePhase) { phase in
            if phase == .inactive {
                // Save scrums when the app goes inactive
                saveScrums()
                saveAction()
            }
        }
    }
}

struct ScrumsView_Previews: PreviewProvider {
    static var previews: some View {
        ScrumsView(scrums: .constant(DailyScrum.sampleData), saveAction: {})
    }
}
