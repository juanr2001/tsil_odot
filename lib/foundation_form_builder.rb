class FoundationFormBuilder < ActionView::Helpers::FormBuilder
    #so I can user content_tag div
    include ActionView::Helpers::TagHelper
    #capture a block of text
    include ActionView::Helpers::CaptureHelper
    #manipulate text in forms
    include ActionView::Helpers::TextHelper

    attr_accessor :output_buffer

end