//
//  ContentString.swift
//  AssistRatingFeedbackKit
//
//  Created by Venkatram G V on 01/02/23.
//

import SwiftUI

@available(iOS 14.0, *)
struct AssistRateUsFeedbackContent {
    
    
    static let feedback: Text                   = Text("AssistRatingFeedbackKit_Feedback", bundle: podBundle)
    static let cancel: Text                     = Text("AssistRatingFeedbackKit_Cancel", bundle: podBundle)
    static let submit: Text                     = Text("AssistRatingFeedbackKit_Submit", bundle: podBundle)
    static let howWouldYouRate: Text            = Text("AssistRatingFeedbackKit_how_Would_You_Rate", bundle: podBundle)
    static let howWouldYouRateDescription: Text = Text("AssistRatingFeedbackKit_how_Would_You_Rate_Description", bundle: podBundle)
    static let enterEmailId                     = NSLocalizedString("AssistRatingFeedbackKit_EnterEmailId", bundle: podBundle, comment: "")
    static let enterEmailIdOptional             = NSLocalizedString("AssistRatingFeedbackKit_EnterEmailIdOptional", bundle: podBundle, comment: "")
    static let enterComment: Text               = Text( "AssistRatingFeedbackKit_EnterComment", bundle: podBundle)
    static let enterCommentOptional: Text       = Text("AssistRatingFeedbackKit_EnterCommentOptional", bundle: podBundle)
    
    static let ok                               = NSLocalizedString("AssistRatingFeedbackKit_Alert_OK",bundle:podBundle, comment: "")
    static let thankYou                         = NSLocalizedString("AssistRatingFeedbackKit_Alert_Thank_you",bundle:podBundle, comment: "")
    static let badReview                        = NSLocalizedString("AssistRatingFeedbackKit_Alert_BadReview",bundle:podBundle, comment: "")
    static let goodReview                       = NSLocalizedString("AssistRatingFeedbackKit_Alert_GoodReview",bundle:podBundle, comment: "")
    static let goodReviewCustomer               = NSLocalizedString("AssistRatingFeedbackKit_Alert_GoodReview_Customer",bundle:podBundle, comment: "")
    static let greatReview                      = NSLocalizedString("AssistRatingFeedbackKit_Alert_GreatReview",bundle:podBundle, comment: "")
    static let greatReviewCustomer              = NSLocalizedString("AssistRatingFeedbackKit_Alert_GreatReview_Customer",bundle:podBundle, comment: "")
    static let rateZohoAssist                   = NSLocalizedString("AssistRatingFeedbackKit_Alert_Rate_Zoho_Assist",bundle:podBundle, comment: "")
    static let rateAssistCustomer               = NSLocalizedString("AssistRatingFeedbackKit_Alert_Rate_Assist_Customer",bundle:podBundle, comment: "")
    static let copyCommentToClipboard           = NSLocalizedString("AssistRatingFeedbackKit_Alert_copy_comment_clipboard",bundle:podBundle, comment: "")
    
    static let badAppStoreReview = NSLocalizedString("AssistRatingFeedbackKit_Alert_BadReview_appStore",bundle:podBundle, comment: "")
    static let goodAppStoreReview = NSLocalizedString("AssistRatingFeedbackKit_Alert_GoodReview_appStore",bundle:podBundle, comment: "")
    static let greatAppStoreReview = NSLocalizedString("AssistRatingFeedbackKit_Alert_GreatReview_appStore",bundle:podBundle, comment: "")
    static let badSimpleReview = NSLocalizedString("AssistRatingFeedbackKit_Alert_BadReview_",bundle:podBundle, comment: "")
    static let goodSimpleReview = NSLocalizedString("AssistRatingFeedbackKit_Alert_GoodReview_",bundle:podBundle, comment: "")
    static let okaySimpleReview = NSLocalizedString("AssistRatingFeedbackKit_Alert_GoodReview_",bundle:podBundle, comment: "")
    static let greatSimpleReview  = NSLocalizedString("AssistRatingFeedbackKit_Alert_GreatReview_",bundle:podBundle, comment: "")
    
    static let thankyou_for_feedback = NSLocalizedString("AssistRatingFeedbackKit_Alert_Thankyou",bundle:podBundle, comment: "")
    static let share_your_experience = NSLocalizedString("AssistRatingFeedbackKit_Alert_ShareYourExperience",bundle:podBundle, comment: "")

    static let notNow                           = NSLocalizedString("AssistRatingFeedbackKit_Alert_NotNow",bundle:podBundle, comment: "")
    static let rate                             = NSLocalizedString("AssistRatingFeedbackKit_Alert_Rate",bundle:podBundle, comment: "")
    static let review_now                       = NSLocalizedString("AssistRatingFeedbackKit_Alert_ReviewNow",bundle:podBundle, comment: "")
    static let cancelString                     = NSLocalizedString("AssistRatingFeedbackKit_Cancel",bundle:podBundle,comment: "")
    static let bad                              = NSLocalizedString("AssistRatingFeedbackKit_Bad", bundle: podBundle, comment: "")
    static let good                             = NSLocalizedString("AssistRatingFeedbackKit_Good", bundle: podBundle, comment: "")
    static let okay                             = NSLocalizedString("AssistRatingFeedbackKit_Okay", bundle: podBundle, comment: "")
    static let great                            = NSLocalizedString("AssistRatingFeedbackKit_Great", bundle: podBundle, comment: "")

    // Bad Feedback
    static let badInaudibleAudio = NSLocalizedString("AssistRatingFeedbackKit_Bad_Inaudible_Audio", bundle: podBundle, comment: "Inaudible Audio")
    static let badScreenFreeze = NSLocalizedString("AssistRatingFeedbackKit_Bad_Screen_Freeze", bundle: podBundle, comment: "Screen Freeze")
    static let badFeaturesNotWork = NSLocalizedString("AssistRatingFeedbackKit_Bad_Features_not_work", bundle: podBundle, comment: "Features did not work as expected")
    static let badInsufficientFeatures = NSLocalizedString("AssistRatingFeedbackKit_Bad_Insufficient features", bundle: podBundle, comment: "Insufficient features")
    static let badUIIsNotFriendly = NSLocalizedString("AssistRatingFeedbackKit_Bad_UI_is_not_friendly", bundle: podBundle, comment: "UI is not friendly")

    // Okay Feedback
    static let okayAudioWasChoppy = NSLocalizedString("AssistRatingFeedbackKit_Okay_Audio_was_choppy", bundle: podBundle, comment: "Audio was choppy")
    static let okayAnnotationsNotAccurate = NSLocalizedString("AssistRatingFeedbackKit_Okay_Annotations_not_accurate", bundle: podBundle, comment: "Annotations were not accurate")
    static let okayScreenLag = NSLocalizedString("AssistRatingFeedbackKit_Okay_Screen_lag", bundle: podBundle, comment: "Screen lag during session")
    static let okayInsufficientFeatures = NSLocalizedString("AssistRatingFeedbackKit_Okay_Insufficien_features", bundle: podBundle, comment: "Insufficient features")
    static let okayUICluttered = NSLocalizedString("AssistRatingFeedbackKit_Okay_UI_cluttered", bundle: podBundle, comment: "UI is cluttered")

    // Great Feedback
    static let greatGoodAudio = NSLocalizedString("AssistRatingFeedbackKit_Great_Good_audio", bundle: podBundle, comment: "Good audio quality")
    static let greatSeamlessConnection = NSLocalizedString("AssistRatingFeedbackKit_Great_Seamless_connection", bundle: podBundle, comment: "Seamless connection")
    static let greatAccurateAnnotations = NSLocalizedString("AssistRatingFeedbackKit_Great_Accurate_Annotations", bundle: podBundle, comment: "Accurate Annotations")
    static let greatQuickFileTransfer = NSLocalizedString("AssistRatingFeedbackKit_Great_Quick_File", bundle: podBundle, comment: "Quick File transfer")
    static let greatOverallExperience = NSLocalizedString("AssistRatingFeedbackKit_Great_Overall_Great", bundle: podBundle, comment: "Overall Great session experience")
    static let rateYourSessionDescriptionText = NSLocalizedString("AssistRatingFeedbackKit_Rate_your_session_experience_Description", bundle: podBundle, comment: "Leave us a feedback and help us improve Zoho Assist Customer app further")
    static let howWouldYouRateTheSession = NSLocalizedString("AssistRatingFeedbackKit_how_Would_You_Rate_The_Session", bundle: podBundle, comment: "How would you rate the session experience?")
    
    static let badFlowCntent                              = NSLocalizedString("AssistRatingFeedbackKit_Bad", bundle: podBundle, comment: "")
    static let goodFlowCntent                             = NSLocalizedString("AssistRatingFeedbackKit_Okay", bundle: podBundle, comment: "")
    static let greatFlowCntent                            = NSLocalizedString("AssistRatingFeedbackKit_Great", bundle: podBundle, comment: "")
    
    static let rateYourSession: Text            = Text("AssistRatingFeedbackKit_Rate_your_session_experience", bundle: podBundle)
    static let rateYourSessionDescription: Text = Text("AssistRatingFeedbackKit_Rate_your_session_experience_Description", bundle: podBundle)
    
    static let includeSystemLogs                = NSLocalizedString("AssistRatingFeedbackKit_Includ_System_Logs", bundle: podBundle, comment: "")
    static let viewLogs                         = NSLocalizedString("AssistRatingFeedbackKit_View_Logs", bundle: podBundle, comment: "")

    static let systemLogDisable_Title           = NSLocalizedString("AssistRatingFeedbackKit_System_Logs_Disabled_Title", bundle: podBundle, comment: "")
    static let systemLogDisable_Description     = NSLocalizedString("AssistRatingFeedbackKit_System_Logs_Disabled_Desctiption", bundle: podBundle, comment: "")

}
