//
//  ViewModel.swift
//  Drag and Drop sample2
//
//  Created by Venkatram G V on 10/01/23.
//

import SwiftUI
import Combine
let podBundle = Bundle(for: AssistRateUsFeedbackViewModel.self)

extension CaseIterable where Self: Equatable {
    var index: Self.AllCases.Index? {
        return Self.allCases.firstIndex { self == $0 }
    }
}

@available(iOS 14.0, *)
public enum AssistFeedbackdReviews: String,CaseIterable{
    case bad = "bad", okay = "okay" , great = "great", good = "good"
    
    var emoji:Image{
        
        switch self {
        case .bad:
            return Image("bad", bundle: podBundle)
        case .good:
            return Image("good", bundle: podBundle)
        case .great:
            return  Image("great", bundle: podBundle)
        case .okay:
            return  Image("", bundle: podBundle) // Not in using
        }
    }
    
    var selectedEmoji:Image{
        
        switch self {
        case .bad:
            return Image("badSelected", bundle: podBundle)
        case .good:
            return Image("goodSelected", bundle: podBundle)
        case .great:
            return  Image("greatSelected", bundle: podBundle)
        case .okay:
            return  Image("", bundle: podBundle)  // Not in using
        }
    }
    
    var emojiColor:Color {
        
        switch self {
        case .bad:
            return Color("badColor", bundle: podBundle)
        case .good:
            return Color("goodColor", bundle: podBundle)
        case .great:
            return Color("greatColor", bundle: podBundle)
        case .okay:
            return Color("", bundle: podBundle)  // Not in using
        }
    }
    
    var title:String{
        switch self{
        case .bad:
            return AssistRateUsFeedbackContent.bad
        case .good:
            return AssistRateUsFeedbackContent.good
        case .great:
            return AssistRateUsFeedbackContent.great
        case .okay:
            return AssistRateUsFeedbackContent.okay
        }
    }
    
    var emojiImageTitle:String{
        switch self{
        case .bad:
            return "sad"
        case .good:
            return "neutral"
        case .great:
            return "love"
        case .okay:
            return "neutral"
        }
        
    }
    
    var takeMeToAppStoreAlertBody: String{
        switch self{
            
        case .bad:
            return AssistRateUsFeedbackContent.badAppStoreReview
        case .good:
            return AssistRateUsFeedbackContent.goodAppStoreReview
        case .great:
            return AssistRateUsFeedbackContent.greatAppStoreReview
        case .okay:
            return AssistRateUsFeedbackContent.okaySimpleReview
        }
    }
    
    var takeMeToAppStoreTitle: String{
        switch self {
        case .bad, .good, .great, .okay :
            return AssistRateUsFeedbackContent.share_your_experience
        }
    }
    
    var normalAlertBody: String {
        switch self{
            
        case .bad:
            return AssistRateUsFeedbackContent.badSimpleReview
        case .good:
            return AssistRateUsFeedbackContent.goodSimpleReview
        case .great:
            return AssistRateUsFeedbackContent.greatSimpleReview
        case .okay:
            return AssistRateUsFeedbackContent.greatSimpleReview
        }
    }
    
    var normalAlertTitle: String{
        switch self {
        case .bad, .good, .great, .okay:
            return AssistRateUsFeedbackContent.thankyou_for_feedback
        }
    }
    
    var flowTitles: [String] {
        switch self {
        case .bad:
            return [
                AssistRateUsFeedbackContent.badInaudibleAudio,
                AssistRateUsFeedbackContent.badScreenFreeze,
                AssistRateUsFeedbackContent.badFeaturesNotWork,
                AssistRateUsFeedbackContent.badInsufficientFeatures,
                AssistRateUsFeedbackContent.badUIIsNotFriendly
            ]
        case .okay:
            return [
                AssistRateUsFeedbackContent.okayAudioWasChoppy,
                AssistRateUsFeedbackContent.okayAnnotationsNotAccurate,
                AssistRateUsFeedbackContent.okayScreenLag,
                AssistRateUsFeedbackContent.okayInsufficientFeatures,
                AssistRateUsFeedbackContent.okayUICluttered
            ]
        case .great:
            return [
                AssistRateUsFeedbackContent.greatGoodAudio,
                AssistRateUsFeedbackContent.greatSeamlessConnection,
                AssistRateUsFeedbackContent.greatAccurateAnnotations,
                AssistRateUsFeedbackContent.greatQuickFileTransfer,
                AssistRateUsFeedbackContent.greatOverallExperience
            ]
        case .good:
            return [
                AssistRateUsFeedbackContent.okayAudioWasChoppy,
                AssistRateUsFeedbackContent.okayAnnotationsNotAccurate,
                AssistRateUsFeedbackContent.okayScreenLag,
                AssistRateUsFeedbackContent.okayInsufficientFeatures,
                AssistRateUsFeedbackContent.okayUICluttered
            ]
        }
    }   
}

@available(iOS 14.0, *)
public struct FeedbackViewObject{
    internal init(review: AssistFeedbackdReviews, emailId: String, comment: String? = nil, quickComment: String? = nil, sendLog: Bool = false) {
        self.review = review
        self.emailId = emailId
        self.comment = comment
        self.quickComment = quickComment
        self.sendLog = sendLog
    }
    
    public var review: AssistFeedbackdReviews
    public var emailId: String
    public var quickComment: String?
    public var comment: String?
    public var sendLog: Bool
}

// MARK: AssistRateUsFeedbackViewModel
@available(iOS 14.0, *)
public class AssistRateUsFeedbackViewModel: ObservableObject {
    
    @Published var emailId: String = ""
    
    @Published var comment: String = ""
    
    @Published var isValid: Bool = false
    
    @Published var selectedReview: AssistFeedbackdReviews?
    
    let viewLogButtonTapped = PassthroughSubject<Void, Never>()
    
    let showAlert = PassthroughSubject<Void, Never>()
    
    var isEmailIdMandatory: Bool? = true
    
    
    
    // An AnyCancellable instance automatically calls cancel() when deinitialized.
    // if didn't use, this can cause memory leaks and other issues, because the subscriptions will retain references to the view and its properties, preventing them from being deallocated.
    private var cancellableSet = Set<AnyCancellable>()
    
    var isEmailAddressValid: AnyPublisher<Bool, Never>{    // returns a publisher that emits Boolean values and never fails.
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        
        return $emailId
        
        // map uses a closure to transform each element it receives from the upstream publisher.
        // map is used to transform from one kind of element to another.
            .map{ value in
                if let isEmailIdMandatory = self.isEmailIdMandatory, !isEmailIdMandatory  {
                    if value.isEmpty {
                        return true
                    }
                }
                
                do {
                    let regex = try NSRegularExpression(pattern: emailRegEx)
                    let nsString = value as NSString
                    let results = regex.matches(in: value, range: NSRange(location: 0, length: nsString.length))
                    
                    
                    if results.count == 0
                    {
                        return false
                    }
                    
                } catch let error as NSError {
                    print("invalid regex: \(error)")
                    return false
                }
                return  true
            }
            .eraseToAnyPublisher()
        
    }
    
    var isCommentTextValid: AnyPublisher<Bool, Never>{
        $comment
            .map{ value in
                let trimmedValue = value.trimmingCharacters(in: .whitespaces)
                return trimmedValue != "" // MOM
            }
        //    The eraseToAnyPublisher() function is being used to convert the publisher to AnyPublisher<Bool, Never>.
        //    This function is used to erase the type of the publisher, so that it can be returned as AnyPublisher<Bool, Never> rather than a specific publisher type.
        // Error: Cannot convert return expression of type 'Publishers.Map<Published<String>.Publisher, Bool>' to return type 'AnyPublisher<Bool, Never>'
            .eraseToAnyPublisher()
    }
    
    
    var reviewSelected: AnyPublisher<Bool, Never>{
        Publishers.CombineLatest3(isEmailAddressValid, isCommentTextValid, $selectedReview)
            .map{email, commentText, reaction in
                switch reaction{
                    
                case.bad:
                    return email && commentText
                case .good:
                    return email && commentText
                case .great:
                    return email
                default:
                    return false
                }
                
            }
            .eraseToAnyPublisher()
    }
    
    init() {
        reviewSelected
        
        //The sink function is being used to subscribe to the publisher and receive the transformed values.
            .sink { [weak self] value in
                self?.isValid = value
            }
        //The store function is used to store the subscription in a set of cancellable instances, so that it can be cancelled later
            .store(in: &cancellableSet)
        
    }
    
    deinit {
        cancellableSet.forEach { $0.cancel() }
        cancellableSet.removeAll()
        print("AssistRateUsFeedbackViewModel deinit")
    }
    
}
