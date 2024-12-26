//
//  ResourcesManager.swift
//  JourneyBook
//
//

import SwiftUI
import SwiftData
import AVKit

struct ResourceView : View {
    var resource : VisualResource
    
    
    var body : some View {
        Form {
            if resource.resourceType == .image {
                Section("Photo") {
                    Image(uiImage: UIImage(data: resource.resourceData) ?? UIImage.init())
                        .resizable()
                        .frame(height: 300)
                        .frame(maxWidth: .infinity)
                        .aspectRatio(contentMode: .fit)
                        .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))


                }
            }
            if resource.resourceType == .video {
                if let url = resource.resourceData.dataToVideoURL() {
                    Section("Video") {
                        VideoPlayer(player: AVPlayer(url:url))
                            .frame( height: 300)
                            .frame(maxWidth: .infinity)
                            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                    }
                }
                
            }
        }
        .navigationTitle(resource.aidDescription ?? "Untitled Resource")
        .navigationBarTitleDisplayMode(.inline)
    }
}
struct ResourcesManager: View {
    @EnvironmentObject private var coordinator: Coordinator
    
    @State private var sheet : ResourcesManagerSheet? = nil
    
    @Query var resources: [VisualResource]
    @Environment(\.modelContext) var modelContext
    
    
    @ViewBuilder
    func contents(for resource : VisualResource) -> some View {
        if let description = resource.aidDescription {
            Text(description)
        }
        
    }
    
    func delete(at offsets: IndexSet) {
        for offset in offsets {
            let resource = resources[offset]
            modelContext.delete(resource)
        }
        do {
            try modelContext.save()
        } catch {
            
        }
    }
    
    var body: some View {
        List {
            ForEach(resources) { resource in
                HStack {
                    Button {
                        coordinator.push(page: .resourceDetails(resource))
                    } label: {
                        contents(for: resource)
                    }
                }
            }
            .onDelete(perform: delete)
            
            
        }
       
        .navigationTitle("Resources")
        .overlay {
            if resources.isEmpty {
                ContentUnavailableView {
                    Label("No Resources", systemImage: "archivebox.fill")
                } description: {
                    Text("Resources that you add will appear here.")
                }
            }
        }
        .sheet(item: $sheet) { item in
            item.buildView()
        }
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Menu {
                    Button {
                        sheet = .addPhoto
                    } label: {
                        Label("Add Photo", systemImage: "photo.artframe")
                    }
                    Button {
                        sheet = .addVideo
                        
                    } label: {
                        Label("Add Video", systemImage: "videoprojector")
                    }
                } label: {
                    Label("Add", systemImage: "plus")
                }
            }
            
        }
    }
    
}

#Preview {
    ResourcesManager()
}


