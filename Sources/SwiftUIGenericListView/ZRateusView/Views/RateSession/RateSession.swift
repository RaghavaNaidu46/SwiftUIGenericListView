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
    func sendObject(object: FeedbackViewObject)
    func enableSystemLogs(status: Bool)
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
    var systemLog: Bool { get }
    var showSystemLogField: Bool { get }
    var logFieldValues: (viewTitle:String, viewButtonTitle:String, logContent:String) {get}
    var successFieldValues: (title:String, imageName:String) {get}
}

// Main view for rating a session
public struct RateSession: View {
    public var dataProvider: RateSessionDataProvider
    @State private var selectedOption: FeedbackOption?
    public var sendAction: (FeedbackViewObject) -> Void // Closure to send data back to the parent view
    @State var feedbackObj = FeedbackViewObject(review: .good, emailId: "")
    @State private var showSheet = false
    @State private var isViewExpanded = false
    @State private var contentHeight: CGFloat? = .zero
    @StateObject private var viewModel = GenericListViewModel(dataSource: FeedbackDataSource())
    @State private var bg: Color = Color(hex: "F29E39", alphaPercentage: 10)
    public var cHeight: (CGFloat) -> Void
    @Binding var returnContentHeight: Bool?
    @State private var selectedRatingIndex: Int?
    @Environment(\.colorScheme) var colorScheme
    
    public init(dataProvider: RateSessionDataProvider, sendAction:@escaping (FeedbackViewObject) -> Void, returnContentHeight: Binding<Bool?>? = nil, cHeight: @escaping (CGFloat) -> Void){
        self.dataProvider = dataProvider
        self.sendAction = sendAction
        self.cHeight = cHeight
        self._returnContentHeight = returnContentHeight ?? .constant(false)
    }
    
    public var body: some View {
        VStack{
            GenericListView(sections: viewModel.sections,
                            contentHeight: $contentHeight,
                            headerMinHeight: 0,
                            returnContentHeight: $returnContentHeight,
                            cHeight: { hh in
                cHeight(hh)
            })
        }
        .overlay(RoundedRectangle(cornerRadius: 10)
            .stroke(isViewExpanded ? .clear : Color(hex: "#F29E39", alphaPercentage: 50), lineWidth: 3)
            .padding(.bottom, -2)
        )
        //.clipShape(RoundedRectangle(cornerRadius: 10))
        .background(isViewExpanded ? dataProvider.contentBG : Color(hex: "#F29E39", alphaPercentage: 15))
        .onAppear {
            viewModel.sections.removeAll()
            viewModel.sections.append(self.prepareInitialDataSource(dp: dataProvider.emojiHighlightStyle))
        }
        .ignoresSafeArea(.container, edges: .bottom)
    }
}

// MARK: - Helper Extensions
extension RateSession {
    // Prepare initial data source for the list
    func prepareInitialDataSource(dp: HighlightStyle) -> SectionItem {
        // Emoji view
        return SectionItem(title: dataProvider.feedbackTitle,
                           items: .staticHView(self.prepareEmots()),
                           centerAlignHorizontal: true,
                           selectedItem: selectedRatingIndex,
                           backgroundColor: dataProvider.contentBG,
                           sectionStyle: GenericStyle(sectionStyle: SectionStyle(
                            headerBackgroundColor: dataProvider.contentBG,
                            headerTextAlignment: .center,
                            headerFont: Font.system(size: 25, weight: .semibold),
                            headerColor: (colorScheme == .dark ? Color.white : Color.black),
                            headerPadding: EdgeInsets()),
                                                      highlightStyle: dp
                           ),
                           verticalSpacing:20,
                           action: { index in
            contentHeight = 0
            feedbackObj.comment = nil
            feedbackObj.quickComment = nil
            feedbackObj.review = AssistFeedbackdReviews.allCases[index]
            selectedRatingIndex = index
            bg = .clear
            self.selectedOption = FeedbackOption.allCases[index]
            isViewExpanded = true
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
        viewModel.sections.removeAll()
        let dp = HighlightStyle(initialBackground: .clear, background: dataProvider.emojiHighlightStyle.selectedBackground, border: dataProvider.emojiHighlightStyle.border)
        viewModel.sections.append(self.prepareInitialDataSource(dp: dp))
        var newItems = [
            // Flow items view
            SectionItem(title: dataProvider.quickContentTitle,
                        items: .flow(createFlowViews(target: target)),
                        selectedItem: 1,
                        backgroundColor: dataProvider.contentBG,
                        sectionStyle: GenericStyle(
                            sectionStyle: SectionStyle(
                                headerTextAlignment: .leading,
                                headerFont: Font.system(size: 14, weight: .semibold),
                                headerColor: (colorScheme == .dark ? Color.white : Color.black)),
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
            SectionItem(items: .expandableTextView(ExpandableTextViewModel(colorScheme: colorScheme,
                                                                           text: dataProvider.comments,
                                                                           placeholder: dataProvider.placeHolder,
                                                                           highlightStyle: dataProvider.textEntryStyle,
                                                                           action: { text in
                feedbackObj.comment = text
            })),
                        sectionStyle: GenericStyle(rowStyle: SectionRowStyle(rowBorderColor: Color(#colorLiteral(red: 0.03137254902, green: 0.6, blue: 0.2862745098, alpha: 1)))),
                        isGrouped: false)
        ]
        
        if dataProvider.showSystemLogField == true {
            // System Logs view
            newItems.append(
                SectionItem(items: .singleView(AnyView(SystemLogsView(id: 1,
                                                                      isToggled: dataProvider.systemLog,
                                                                      viewTitle: dataProvider.logFieldValues.viewTitle,
                                                                      viewButtonTitle: dataProvider.logFieldValues.viewButtonTitle,
                                                                      logContent: dataProvider.logFieldValues.logContent,
                                                                      switchAction: { _id, status in
                                                                          dataProvider.enableSystemLogs(status: status)
                                                                          feedbackObj.sendLog = status
                                                                      },
                                                                      buttonAction: {
                                                                          print("Button tapped")
                                                                      }))),
                            centerAlignHorizontal: true)
            )
        }
        
        newItems.append(
            SectionItem(items: .singleView(AnyView(SendItemView(title: dataProvider.sendTitle))),
                        centerAlignHorizontal: true,
                        sectionStyle: GenericStyle(rowStyle:
                                                       SectionRowStyle(rowBackgroundColor: .green)
                                                  ),
                        action: { index in
                self.sendAction(feedbackObj)
            })
        )
        
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
