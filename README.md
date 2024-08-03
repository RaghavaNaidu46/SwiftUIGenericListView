# SwiftUIGenericListView

A SwiftUI framework for creating dynamic lists with both horizontal and vertical items.

Features
Horizontal and vertical list sections
Center-aligned horizontal items when specified
Support for dynamic item sizes
Easy to integrate and customize
Installation
Use Swift Package Manager to add the package to your Xcode project:

arduino
Copy code
https://github.com/your-username/SwiftUIGenericListView.git

Usage
Define Your Model
swift

Copy code
    
    struct SectionItem: Identifiable {
        let id = UUID()
        let title: String
        let items: ListItem
        let centerAlignHorizontal: Bool
    }

    enum ListItem {
    case horizontal([AnyView])
    case vertical([AnyView])
    }
    
Create Your Views
swift
Copy code
    
    struct CustomHorizontalItemView: View {
    
    let title: String
    
    var body: some View {
        Text(title)
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(8)
        }
    }

    struct CustomVerticalItemView: View {
        let title: String
    
        var body: some View {
            Text(title)
                .padding()
                .background(Color.blue.opacity(0.2))
                .cornerRadius(8)
        }
    }
    
Use the Framework
swift
Copy code

    struct ContentView: View {
        @StateObject var viewModel = GenericListViewModel(dataSource: SampleDataSource())
    
        var body: some View {
            GenericListView(sections: viewModel.sections)
        }
    }
