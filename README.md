# SwiftUIGenericListView

A SwiftUI framework for creating dynamic lists with both horizontal and vertical items.

**Features**

- Horizontal and vertical list sections.

- Center-aligned horizontal items when specified.

- Support for dynamic item sizes.

- Easy to integrate and customize.

**Installation**

Use Swift Package Manager to add the package to your Xcode project:
https://github.com/RaghavaNaidu46/SwiftUIGenericListView.git

## Usage

**Create Your Views**    

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
    
**Use the Framework**

    struct ContentView: View {
        @StateObject var viewModel = GenericListViewModel(dataSource: SampleDataSource())
        var body: some View {
            GenericListView(sections: viewModel.sections)
        }
    }

**Data Source**
    
    struct SampleDataSource: GenericListDataSource {
        func fetchSections() -> [SectionItem] {
            return [
                SectionItem(title: "Horizontal Section Centered", items: .horizontal([
                    AnyView(CustomHorizontalItemView(title: "Horizontal 1")),
                    AnyView(CustomHorizontalItemView(title: "Horizontal 2"))
                ]), centerAlignHorizontal: true),
                SectionItem(title: "Horizontal Section Not Centered", items: .horizontal([
                    AnyView(CustomHorizontalItemView(title: "Horizontal 3")),
                    AnyView(CustomHorizontalItemView(title: "Horizontal 4")),
                    AnyView(CustomHorizontalItemView(title: "Horizontal 5"))
                ]), centerAlignHorizontal: false),
                SectionItem(title: "Vertical Section", items: .vertical([
                    AnyView(CustomVerticalItemView(title: "Vertical 1")),
                    AnyView(CustomVerticalItemView(title: "Vertical 2")),
                    AnyView(CustomVerticalItemView(title: "Vertical 3"))
                ]), centerAlignHorizontal: false)
            ]
        }
    }


## Happy Coding.
