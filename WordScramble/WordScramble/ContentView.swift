//
//  ContentView.swift
//  WordScramble
//
//  Created by Igor L on 13/11/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    @State private var score = 0
    @State private var highScore = 0
    
    @State private var errorTitle = ""
    @State private var errorMsg = ""
    @State private var showError = false
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    Text("\(highScore)")
                } header: {
                    Text("Highscore")
                }
                
                Section {
                    TextField("Enter you word: ", text: $newWord)
                        .textInputAutocapitalization(.never)
                        // Auto correction can give answers
                        .disableAutocorrection(true)
                }
                
                Section {
                    Text("\(score)")
                } header: {
                    Text("Score")
                }
                
                Section {
                    ForEach(usedWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                    }
                } header: {
                    if !usedWords.isEmpty {
                        Text("Used words")
                    }
                }
            }
            .navigationTitle(rootWord)
            .onSubmit(addNewWord)
            .onAppear(perform: startGame)
            // Challenge 2
            .toolbar {
                Button("New word \(Image(systemName: "play.circle"))", action: startGame)
            }
            .alert(errorTitle, isPresented: $showError) {
                Button("OK") { }
            } message : {
                Text(errorMsg)
            }
            Text("Highscore: \(highScore)")
        }
    }
    
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard answer.count > 0 else { return }
        
        // Challenge 1
        guard answer != rootWord else {
            wordError(title: "That's the root word !", msg: "Find a word derived from its letters !")
            return
        }
        
        guard answer.count >= 2 else {
            wordError(title: "Too easy !", msg: "Try a 2 letter word or higher !")
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "Word not possible", msg: "You can't spell \(answer) from '\(rootWord)'")
            return
        }
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word already used", msg: "Be more original !")
            return
        }
        
        guard isRealWord(word: answer) else {
            wordError(title: "Word not recognised", msg: "You can't just make them up!")
            return
        }
        
        withAnimation {
            usedWords.insert(answer, at: 0)
        }
        
        updateScore(word: answer)
        
        newWord = ""
    }
    
    func startGame() {
        // Restart variables
        usedWords = [String]()
        score = 0
        
        // 1. Find the URL for start.txt in our app bundle
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            // 2. Load start.txt into a string
            if let startWords = try? String(contentsOf: startWordsURL) {
                // 3. Split the string up into an array of strings, splitting on line breaks
                let allWords = startWords.components(separatedBy: "\n")

                // 4. Pick one random word, or use "silkworm" as a sensible default
                rootWord = allWords.randomElement() ?? "silkworm"
                print(rootWord)
                // If we are here everything has worked, so we can exit
                return
            }
        }

        // If were are *here* then there was a problem – trigger a crash and report the error
        fatalError("Could not load start.txt from bundle.")
    }
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord

        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }

        return true
    }
    
    func isRealWord(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let mispelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return mispelledRange.location == NSNotFound
    }
    
    func wordError(title: String, msg: String) {
        errorTitle = title
        errorMsg = msg
        showError = true
        // Clears text field
        newWord = ""
    }
    
    func updateScore(word: String) {
        var extraPoints = word.count - 2
        
        score = score + 1 + extraPoints
        
        if score > highScore {
            highScore = score
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
