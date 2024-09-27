//
//  AllActivities.swift
//  HabitTracker
//
//  Created by Adrino Rosario on 23/09/24.
//

import Observation
import SwiftUI

struct Activity: Identifiable, Codable, Equatable {
    var id = UUID()
    var name: String //using
    var category: String
    var description: String //using
    var activityDate: Date = Date.now //using
    var imageName: String
    var completionCount: Int = 0
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium // You can adjust this
        formatter.timeStyle = .none   // You can adjust this if needed
        return formatter
    }()
}


@Observable
class Activities {
    var activities = [Activity]() {
        didSet { //this only saving, we are not loading the data again and reading it
            if let encoded = try? JSONEncoder().encode(activities) {
                UserDefaults.standard.set(encoded, forKey: "Activities")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Activities") {
            if let decodedItems = try? JSONDecoder().decode([Activity].self, from: savedItems) {
                activities = decodedItems
                return
            }
        }
        activities = []
    }
    
    
}

struct AllActivities: View {
    
    @State private var activities = Activities()
    
    @State private var showingAddActivity: Bool = false
    
    var body: some View {
        NavigationStack {
            
            if(activities.activities.count == 0) {
                VStack {
                    Spacer()
                    Text("Click on the plus button to log an activity")
                        .font(.headline)
                        .foregroundStyle(.secondary)
                }
                .transition(.scale.combined(with: .opacity))
            }

                List {
                    ForEach(activities.activities, id: \.id) { activity in
                            
                            NavigationLink {
                                ActivityView(activity: activity, activities: activities)
                                
                            } label: {
                                VStack(alignment: .leading, spacing: 17) {
                                    HStack(spacing: 15) {
                                        Image(systemName: activity.imageName)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 40, height: 40)
                                            .background(Circle()
                                                .fill(.thickMaterial)
                                                .fill(LinearGradient(colors: [.blue, .pink], startPoint: .top, endPoint: .bottom))
                                                .frame(width: 50, height: 50)
                                                .foregroundColor(.white)
                                            )
                                        
                                        Text(activity.name)
                                            .font(.title3)
                                            .fontWeight(.semibold)
                                    }
                                    
                                    
                                    HStack(alignment: .center, spacing: 15) {
                                        Text("\(activity.activityDate.formatted(date: .abbreviated, time: .omitted))")
                                            .font(.headline)
                                            .frame(maxWidth: 150, maxHeight: 40)
                                            .background(.ultraThinMaterial)
                                            .background(LinearGradient(colors: [.blue, .red, .orange], startPoint: .topLeading, endPoint: .bottomTrailing))
                                            .clipShape(.rect(cornerRadius: 5))
                                        
                                        
                                        Text(activity.category)
                                            .frame(maxWidth: 200, maxHeight: 40)
                                            .background(.ultraThinMaterial)
                                            .background(LinearGradient(colors: [.green, .blue, .indigo, .pink], startPoint: .leading, endPoint: .trailing))
                                            .clipShape(.rect(cornerRadius: 5))
                                            .font(.caption)
                                            .fontWeight(.bold)
                                    }
                                    
                                    
                                    VStack {
                                        Text(activity.description)
                                    }
                                    .frame(maxWidth: 300, maxHeight: 40)
                                    
                                    
                                }
                                .padding(10)
                            }
                    }
                    .onDelete(perform: { indexSet in
                        removeItems(at: indexSet)
                    })
                }
                .navigationTitle("HabitTracker")
                .navigationBarTitleDisplayMode(.large)
                .navigationBarTitleDisplayMode(.automatic)
                .preferredColorScheme(.dark)
                .toolbar {
                    Button("Add new activity", systemImage: "plus.circle.fill") {
                        showingAddActivity.toggle()
                    }
                    .sheet(isPresented: $showingAddActivity, content: {
                        AddActivityView(activities: activities)
                    })
                }
        }
    }
    func removeItems(at offsets: IndexSet) {
        activities.activities.remove(atOffsets: offsets)
    }

}

#Preview {
    AllActivities()
}
