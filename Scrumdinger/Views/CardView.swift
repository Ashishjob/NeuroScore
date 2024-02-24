import SwiftUI

struct CardView: View {
    let scrum: DailyScrum

    var body: some View {
        HStack {
            VStack {
                Text("\(scrum.totalGcs)")
                .font(.title)
                .fontWeight(.bold)
                .accessibilityAddTraits(.isHeader)
            }
            .padding()
            Divider().background(Color.black)
                    .frame(height: 50)
            Spacer()

            VStack(alignment: .leading) {
                Text(scrum.title)
                    .font(.headline)
                    .accessibilityAddTraits(.isHeader)
            }
            .padding()
        }
        .foregroundColor(scrum.theme.accentColor)
        .background(scrum.theme.mainColor)
    }
}


struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        let scrum = DailyScrum.sampleData[0]
        return CardView(scrum: scrum)
            .background(scrum.theme.mainColor)
            .previewLayout(.fixed(width: 400, height: 80))
    }
}
