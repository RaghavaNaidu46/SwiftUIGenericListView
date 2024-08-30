//
//  RateSession.swift
//  TestProduct
//
//  Created by Raghava Dokala on 14/08/24.
//

import SwiftUI

// Enum to represent feedback options
enum FeedbackOption: String, CaseIterable {
    case bad
    case okay
    case great
}

// Struct to hold feedback reactions data
struct FeedbackReactions {
    var text: String
    var imageName: String
    var quickComments: [String]
}

// Protocol to define the data provider for the rate session
protocol RateSessionDataProvider {
    var feedbackTitle: String { get }
    var feedbackEmots: [FeedbackOption: [FeedbackReactions]] { get }
    var quickContentTitle: String { get }
    var comments: String { get }
    var placeHolder: String { get }
    var sendTitle: String { get }
    var emojiHighlightStyle: HighlightStyle { get }
    var flowHighlightStyle: HighlightStyle { get }
    var textEntryStyle: HighlightStyle { get }
}

// Main view for rating a session
public struct RateSession: View {
    var dataProvider: RateSessionDataProvider
    @State private var selectedOption: FeedbackOption?
    public var sendAction: (FeedbackViewObject) -> Void // Closure to send data back to the parent view
    @State var feedbackObj = FeedbackViewObject(review: .good, emailId: "")
    @State private var showSheet = false
    @State private var contentHeight: CGFloat? = .zero
    @StateObject private var viewModel = GenericListViewModel(dataSource: FeedbackDataSource())
    @State private var bg: Color = Color(hex: "F29E39", alpha: 0.1)

    public var body: some View {
        Color.white // Main content background
            .edgesIgnoringSafeArea(.all)
            .onAppear {
                showSheet = true
                viewModel.sections.removeAll()
                viewModel.sections.append(self.prepareInitialDataSource())
            }
            .sheet(isPresented: $showSheet) {
                if #available(iOS 16.0, *) {
                    GenericListView(sections: viewModel.sections, contentHeight: $contentHeight, headerMinHeight: 5)
                        .background($bg.wrappedValue)
                        .presentationDetents([.height(contentHeight ?? 0)])
                        .presentationDragIndicator(.visible)
                        .onDrag {
                            Color.clear.task {
                            } as! NSItemProvider
                        }
                        .onPreferenceChange(HeightPreferenceKey.self) { value in
                            print("Content height: \(value)")
                            contentHeight = value
                        }
                } else {
                    // Fallback for iOS 14 and 15
                    GenericListView(sections: viewModel.sections, contentHeight: $contentHeight, headerMinHeight: 5)
                        .background(Color(UIColor(bg))) // Assuming 'bg' is a Color or can be converted to Color
                        .onPreferenceChange(HeightPreferenceKey.self) { value in
                            print("Content height: \(value)")
                            contentHeight = value
                        }
                }
            }
    }
}

// MARK: - Helper Extensions
extension RateSession {
    // Prepare initial data source for the list
    func prepareInitialDataSource() -> SectionItem {
        // Emoji view
        return SectionItem(title: dataProvider.feedbackTitle,
                           items: .staticHView(self.prepareEmots()),
                           centerAlignHorizontal: true,
                           selectedItem: 1,
                           sectionStyle: GenericStyle(sectionStyle: SectionStyle(
                            backgroundColor: .clear,
                            headerTextAlignment: .center,
                            headerFont: Font.system(size: 25, weight: .semibold),
                            headerColor: .black,
                            headerPadding: EdgeInsets()),
                                                      highlightStyle: dataProvider.emojiHighlightStyle
                           ),
                           action: { index in
            feedbackObj.comment = nil
            feedbackObj.quickComment = nil
            feedbackObj.review = AssistFeedbackdReviews.allCases[index]
            bg = .clear
            self.selectedOption = FeedbackOption.allCases[index]
            appendToDataSource(target: self.selectedOption)
        })
    }

    // Prepare emoticons for display
    private func prepareEmots() -> [AnyView] {
        let flowItemViews: [AnyView] = FeedbackOption.allCases.flatMap { option in
            dataProvider.feedbackEmots[option]?.map { reaction in
                AnyView(EmojiItemView(imgName: reaction.imageName, title: reaction.text))
            } ?? []
        }
        return flowItemViews
    }

    // Append additional data to the data source based on the selected feedback option
    private func appendToDataSource(target: FeedbackOption?) {
        let sections = viewModel.sections
        viewModel.sections = Array(sections.prefix(1))  // Keeps only the first element

        let newItems = [
            // Flow items view
            SectionItem(title: dataProvider.quickContentTitle,
                        items: .flow(createFlowViews(target: target)),
                        centerAlignHorizontal: true,
                        selectedItem: 1,
                        sectionStyle: GenericStyle(
                            sectionStyle: SectionStyle(
                                headerTextAlignment: .leading,
                                headerFont: Font.system(size: 14, weight: .semibold),
                                headerColor: .black,
                                headerPadding: EdgeInsets()),
                            highlightStyle: dataProvider.flowHighlightStyle
                        ),
                        flowAction: { index in
                            let flowItemTitles = getFlowTitles(target: selectedOption)
                            var comment: String {
                                flowItemTitles.indices
                                    .filter { index.contains($0) }
                                    .map { flowItemTitles[$0] }
                                    .joined(separator: ", ")
                            }
                            feedbackObj.quickComment = comment
                        }),
            // Text entry view
            SectionItem(items: .expandableTextView(ExpandableTextViewModel(text: dataProvider.comments,
                                                                           placeholder: dataProvider.placeHolder,
                                                                           highlightStyle: dataProvider.textEntryStyle,
                                                                           action: { text in
                feedbackObj.comment = text
            })),
                        sectionStyle: GenericStyle(rowStyle: SectionRowStyle(rowBorderColor: Color(#colorLiteral(red: 0.03137254902, green: 0.6, blue: 0.2862745098, alpha: 1)))),
                        isGrouped: false),

            // Send button view
            SectionItem(items: .staticButtonView(AnyView(SendItemView(title: dataProvider.sendTitle))),
                        centerAlignHorizontal: true,
                        sectionStyle: GenericStyle(rowStyle:
                                                       SectionRowStyle(rowBackgroundColor: .green)
                                                  ),
                        action: { index in
                self.sendAction(feedbackObj)
            })
        ]
        viewModel.sections.append(contentsOf: newItems)
    }

    // Create flow views based on the selected feedback option
    func createFlowViews(target: FeedbackOption?) -> [AnyView] {
        let flowItemTitles = getFlowTitles(target: target)

        return flowItemTitles.map { title in
            AnyView(FlowView(title: "\(title)"))
        }
    }

    // Get flow titles for the selected feedback option
    private func getFlowTitles(target: FeedbackOption?) -> [String] {
        guard let reactions = dataProvider.feedbackEmots[selectedOption ?? .great] else { return [] }
        return reactions.flatMap { $0.quickComments }
    }
}
