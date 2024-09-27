//
//  AddActivityView.swift
//  HabitTracker
//
//  Created by Adrino Rosario on 13/09/24.
//

import SwiftUI

struct AddActivityView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var name: String = ""
    @State private var category: String = ""
    @State private var habit: String = ""
    @State private var description: String = ""
    @State private var activityDate: Date = Date.now
    

    
    let habitCategories = [
        "Health & Fitness",
        "Mindfulness & Mental Well-being",
        "Learning & Education",
        "Creative Pursuits",
        "Productivity & Organization",
        "Personal Development",
        "Hobbies & Recreation",
        "Social & Relationships",
        "Lifestyle & Daily Routine"
    ]

    
    let habitSymbols: [String: String] = [
        "Exercise": "figure.walk",
        "Meditation": "brain.head.profile",
        "Running": "figure.run",
        "Cycling": "bicycle",
        "Walking": "figure.walk",
        "Stretching": "figure.stretch",
        "Yoga": "figure.yoga",
        "Strength Training": "dumbbell",
        "Swimming": "figure.swimming",
        "Hiking": "figure.hiking",
        "Dancing": "figure.dance",
        "Playing Sports": "sportscourt",
        "Journaling": "square.and.pencil",
        "Daily Gratitude": "hands.sparkles",
        "Mindful Breathing": "wind",
        "Affirmations": "quote.bubble",
        "Therapy Sessions": "person.fill.questionmark",
        "Reading": "book",
        "Language Learning": "globe",
        "Studying": "brain.head.profile",
        "Learning a New Skill": "graduationcap",
        "Coding Practice": "laptopcomputer",
        "Studying for Exams": "books.vertical",
        "Taking Online Courses": "desktopcomputer",
        "Watching Educational Videos": "video",
        "Practicing an Instrument": "music.note",
        "Drawing": "paintbrush",
        "Creative Writing": "pencil.and.outline",
        "Photography": "camera",
        "Painting": "paintpalette",
        "Playing Video Games": "gamecontroller",
        "Singing": "mic",
        "Gardening": "leaf",
        "Woodworking": "hammer",
        "Knitting": "scissors",
        "Cleaning": "sparkles",
        "Cooking": "flame",
        "Meal Planning": "fork.knife",
        "Budgeting": "chart.bar",
        "Goal Setting": "target",
        "Organizing Workspace": "folder",
        "Inbox Zero": "tray",
        "Decluttering": "trash",
        "Calling Family": "phone",
        "Catching Up with Friends": "person.2",
        "Volunteering": "heart.fill",
        "Networking": "person.3.sequence",
        "Sleeping 8 Hours": "bed.double",
        "Drinking Water": "drop",
        "Taking Vitamins": "pills",
        "Skincare Routine": "face.smiling",
        "Limiting Screen Time": "iphone",
        "Social Media Limitation": "iphone.slash",
        "Spending Time Outdoors": "leaf.arrow.circlepath",
        "Reducing Caffeine": "cup.and.saucer",
        "Unplugging from Devices": "power",
        "Taking a Walk": "figure.walk.circle",
        "Self-Care Day": "heart.text.square",
        "Saving Money": "banknote",
        "Tracking Expenses": "chart.bar.doc.horizontal",
        "Investing": "chart.line.uptrend.xyaxis",
        "Paying Bills": "creditcard",
        "Mindful Eating": "fork.knife.circle",
        "Limiting Alcohol": "wineglass",
        "Recycling": "arrow.2.circlepath",
        "Sustainability Efforts": "leaf.fill",
        "Limiting Sugar": "cart",
        "Quit Smoking": "nosign",
        "Donate to Charity": "hands.sparkles.fill"
    ]


    
    var activities: Activities
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                
                Picker("Category", selection: $category) {
                    ForEach(habitCategories, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.menu)
                
                TextField("Enter habit here or select from below", text: $habit)
                
                Picker("Habit", selection: $habit) {
                    ForEach(Array(habitSymbols.keys), id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.menu)
                
                TextField("Write a short description...", text: $description)
                
                VStack {
                    Text("When did you do this?")
                    DatePicker("Select the date", selection: $activityDate, displayedComponents: .date)
                        .labelsHidden()
                }
            }
            .navigationTitle("Add new activity")
            .toolbar {
                Button("Add") {
                    let activity = Activity(name: name, category: category, description: description, activityDate: activityDate,imageName: habitSymbols[habit]!)
                    activities.activities.append(activity)
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    AddActivityView(activities: Activities())
}
