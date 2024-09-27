//
//  ActivityView.swift
//  HabitTracker
//
//  Created by Adrino Rosario on 15/09/24.
//

import SwiftUI

struct ActivityView: View {
    
    var activity: Activity
    var activities: Activities
    
    @State private var completionCount: Int = 0
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 17) {
                Spacer()
                    Text(activity.name)
                        .font(.title)
                        .fontWeight(.semibold)
                    
                    VStack(alignment: .leading, spacing: 15) {
                        Text("\(activity.activityDate.formatted(date: .abbreviated, time: .omitted))")
                            .font(.title2)
                            .frame(maxWidth: .infinity, maxHeight: 50)
                            .background(.ultraThinMaterial)
                            .background(LinearGradient(colors: [.blue, .red, .orange], startPoint: .topLeading, endPoint: .bottomTrailing))
                            .clipShape(.rect(cornerRadius: 5))
                        
                        Text(activity.category)
                            .frame(maxWidth: .infinity, maxHeight: 50)
                            .background(.ultraThinMaterial)
                            .background(LinearGradient(colors: [.green, .blue, .indigo, .pink], startPoint: .leading, endPoint: .trailing))
                            .clipShape(.rect(cornerRadius: 5))
                            .font(.title2)
                            .fontWeight(.bold)
                    }
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Number of times completed: \(completionCount)")
                            Button {
                                completionCount += 1
                            } label: {
                                Image(systemName: "plus.circle")
                            }
                        }
                    }
                    VStack {
                        Text(activity.description)
                            .font(.title3)
                    }
                }
                .navigationTitle(activity.category)
                .frame(maxHeight: 200)
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            Spacer()
        }
        .padding(10)
        .preferredColorScheme(.light)
    }
    
    func updateCompletionCount() {
        if let index = activities.activities.firstIndex(where: { $0.id == activity.id }) {
            activities.activities[index].completionCount = completionCount
        }
    }
}

#Preview {
    ActivityView(activity: Activity(name: "Cooking", category: "Cooking", description: "Cooking something", imageName: "cooktop", completionCount: 0), activities: Activities())
}
