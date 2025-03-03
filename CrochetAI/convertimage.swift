import SwiftUI
import PhotosUI

struct ConvertImageView: View {
    @State private var selectedImage: UIImage?
    @State private var isImagePickerPresented = false
    @State private var isProcessing = false
    @State private var showCancelConfirmation = false
    
    // Sample history data
    let recentHistory = [
        HistoryItem(title: "Cartoon Crochet", level: "Beginner", timeAgo: "2 hours"),
        HistoryItem(title: "Cat Crochet", level: "Beginner", timeAgo: "2 hours"),
        HistoryItem(title: "Crochet Accessories", level: "Beginner", timeAgo: "2 hours")
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(spacing: 24) {
                    // Upload Image Section
                    VStack(spacing: 16) {
                        Text("Upload Image")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        // Image Upload Area
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.gray.opacity(0.3), style: StrokeStyle(lineWidth: 2, dash: [6]))
                                .background(Color.gray.opacity(0.05))
                                .frame(height: 200)
                            
                            if let selectedImage = selectedImage {
                                Image(uiImage: selectedImage)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 180)
                            } else {
                                VStack(spacing: 12) {
                                    Image(systemName: "arrow.up.doc")
                                        .font(.system(size: 40))
                                        .foregroundColor(Color.pc)
                                    
                                    Text("Drop file or browse")
                                        .font(.system(size: 16, weight: .medium))
                                    
                                    Text("Format: .jpeg, .png & Max file size: 25 MB")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            isImagePickerPresented = true
                        }
                        
                        // Buttons
                        Button(action: {
                            convertImage()
                        }) {
                            if isProcessing {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            } else {
                                Text("Generate")
                                    .frame(maxWidth: .infinity)
                                    .fontWeight(.medium)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .frame(height: 40)
                        .background(selectedImage == nil ? Color.pc.opacity(0.5) : Color.pc)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .disabled(selectedImage == nil || isProcessing)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(radius: 2)
                    .padding(.horizontal)
                    
                    // Recent History Section
                    VStack(spacing: 16) {
                        Text("Recent History")
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        ForEach(recentHistory) { item in
                            HistoryItemView(item: item)
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(radius: 2)
                    .padding(.horizontal)
                }
                .padding(.vertical)
            }
        }
        .sheet(isPresented: $isImagePickerPresented) {
            ImagePicker(image: $selectedImage)
        }
        .alert(isPresented: $showCancelConfirmation) {
            Alert(
                title: Text("Cancel Upload"),
                message: Text("Are you sure you want to cancel this upload?"),
                primaryButton: .destructive(Text("Yes")) {
                    selectedImage = nil
                },
                secondaryButton: .cancel(Text("No"))
            )
        }
    }
    
    func convertImage() {
        // Simulate processing
        isProcessing = true
        
        // In a real app, you would implement your conversion logic here
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            isProcessing = false
            // Navigate to result screen or show success message
        }
    }
}

// Image Picker (using PHPickerViewController)
struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Environment(\.presentationMode) private var presentationMode
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        config.selectionLimit = 1
        
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            parent.presentationMode.wrappedValue.dismiss()
            
            guard let provider = results.first?.itemProvider else { return }
            
            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) { image, error in
                    DispatchQueue.main.async {
                        self.parent.image = image as? UIImage
                    }
                }
            }
        }
    }
}

// History Item Model
struct HistoryItem: Identifiable {
    let id = UUID()
    let title: String
    let level: String
    let timeAgo: String
}

// History Item View
struct HistoryItemView: View {
    let item: HistoryItem
    
    var body: some View {
        HStack(spacing: 16) {
            // Placeholder for pattern preview
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.gray.opacity(0.2))
                .frame(width: 60, height: 60)
                .overlay(
                    Image(systemName: "photo")
                        .foregroundColor(.gray)
                )
            
            VStack(alignment: .leading, spacing: 4) {
                Text(item.title)
                    .font(.system(size: 16, weight: .medium))
                
                Text("\(item.level) • \(item.timeAgo)")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.gray.opacity(0.05))
        .cornerRadius(12)
    }
}



// Integrated View that combines segmented control from existing code
struct GenerateIdeaAndConvertView: View {
    @State private var selectedOption = 0
    let options = ["Generate Idea", "Convert Image"]
    @State private var projectDescription = ""
    @State private var showPreferences = false
    
    init() {
        // Set the selected segment tint color
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor.pc
        
        // Set the selected text color to white
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        
        // Set the normal text color to black
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Logo - fixed position for both views
            HStack {
                Image("crochet icon")
                    .padding(.leading, 20)
                Spacer()
            }
            .padding(.top, 10)
            .background(Color.white)
            
            // Segment Control - fixed position
            Picker("", selection: $selectedOption) {
                ForEach(0..<options.count, id: \.self) { index in
                    Text(options[index]).tag(index)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            .background(Color.white)
            
            // Content View based on selection
            if selectedOption == 0 {
                // Generate Idea View
                GenerateIdeaContent(
                    projectDescription: $projectDescription,
                    showPreferences: $showPreferences
                )
            } else {
                // Convert Image View
                ConvertImageView()
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

// Extracted Generate Idea content to match the existing code
struct GenerateIdeaContent: View {
    @Binding var projectDescription: String
    @Binding var showPreferences: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack {
                    HStack {
                        Text("Generate Idea")
                            .font(.title2)
                            .fontWeight(.semibold)
                        Spacer()
                    }
                    
                    TextField("Describe your dream crochet project...", text: $projectDescription, axis: .vertical)
                        .lineLimit(5)
                        .padding(.horizontal, 10)
                        .padding(.top, 10)
                        .frame(height: 90, alignment: .top)
                        .background(Color.white)
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                        )
                        .multilineTextAlignment(.leading)
                    
                    Button(action: {
                        // Add action here
                    }) {
                        Text("Generate Ideas")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .frame(height: 40)
                            .background(Color.pc)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .contentShape(Rectangle())
                    
                    Button(action: { showPreferences.toggle() }) {
                        HStack {
                            Image(systemName: "slider.horizontal.3")
                                .foregroundColor(.black)
                            Text("Show Preferences")
                                .foregroundColor(.black)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .frame(height: 40)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 1)
                        )
                    }
                    
                    // Preferences Section
                    PreferencesView()
                        .opacity(showPreferences ? 1 : 0)
                        .animation(.easeInOut, value: showPreferences)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 12).fill(Color.white).shadow(radius: 2))
                .padding()
            }
        }
    }
}

// Preview
struct GenerateIdeaAndConvertView_Previews: PreviewProvider {
    static var previews: some View {
        GenerateIdeaAndConvertView()
    }
}

