//
//  RateSession.swift
//  TestProduct
//
//  Created by Raghava Dokala on 14/08/24.
//

import SwiftUI

// Enum to represent feedback options
public enum FeedbackOption: String, CaseIterable {
    case bad
    case okay
    case great
}

// Struct to hold feedback reactions data
public struct FeedbackReactions {
    public var text: String
    public var imageName: String
    public var quickComments: [String]

    // Public initializer
    public init(text: String, imageName: String, quickComments: [String]) {
        self.text = text
        self.imageName = imageName
        self.quickComments = quickComments
    }
}


// Protocol to define the data provider for the rate session
public protocol RateSessionDataProvider {
    var feedbackTitle: String { get }
    var feedbackEmots: [FeedbackOption: [FeedbackReactions]] { get }
    var quickContentTitle: String { get }
    var comments: String { get }
    var placeHolder: String { get }
    var sendTitle: String { get }
    var emojiHighlightStyle: HighlightStyle { get }
    var flowHighlightStyle: HighlightStyle { get }
    var textEntryStyle: HighlightStyle { get }
    var contentBG: Color { get }
}

// Main view for rating a session
public struct RateSession: View {
    public var dataProvider: RateSessionDataProvider
    @State private var selectedOption: FeedbackOption?
    public var sendAction: (FeedbackViewObject) -> Void // Closure to send data back to the parent view
    @State var feedbackObj = FeedbackViewObject(review: .good, emailId: "")
    @State private var showSheet = false
    @State private var contentHeight: CGFloat? = .zero
    @StateObject private var viewModel = GenericListViewModel(dataSource: FeedbackDataSource())
    @State private var bg: Color = Color(hex: "F29E39", alpha: 0.1)
    public var cHeight: (CGFloat) -> Void
    
    public init(dataProvider: RateSessionDataProvider, sendAction:@escaping (FeedbackViewObject) -> Void, cHeight: @escaping (CGFloat) -> Void){
        self.dataProvider = dataProvider
        self.sendAction = sendAction
        self.cHeight = cHeight
    }
    
    public var body: some View {
        VStack{
            GenericListView(sections: viewModel.sections, contentHeight: $contentHeight, headerMinHeight: 5, cHeight: { hh in
                cHeight(hh)
            })
        }
        .onAppear {
            viewModel.sections.removeAll()
            viewModel.sections.append(self.prepareInitialDataSource())
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
                           backgroundColor: dataProvider.contentBG,
                           sectionStyle: GenericStyle(sectionStyle: SectionStyle(
                            headerBackgroundColor: dataProvider.contentBG,
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
                        selectedItem: 1,
                        backgroundColor: dataProvider.contentBG,
                        sectionStyle: GenericStyle(
                            sectionStyle: SectionStyle(
                                headerTextAlignment: .leading,
                                headerFont: Font.system(size: 14, weight: .semibold),
                                headerColor: .black),
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
