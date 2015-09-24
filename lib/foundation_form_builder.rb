class FoundationFormBuilder < ActionView::Helpers::FormBuilder
    #so I can user content_tag div
    include ActionView::Helpers::TagHelper
    #capture a block of text
    include ActionView::Helpers::CaptureHelper
    #manipulate text in forms
    include ActionView::Helpers::TextHelper

    attr_accessor :output_buffer

    #erros_on? - call  line 46
    def errors_on?( attribute )
        object.errors[ attribute ].size > 0
    end

    #wrapper block - defined line 25
   def submit( text, options = {} )
        options[ :class ] ||= "button radius expand"
        wrapper do
            super( text, options )
        end
   end
   # :wrapper_classes - defined line 47, call line 19 and 49
   #capture - CaptureHelper
   def wrapper( options = {}, &block )
        content_tag( :div, class: "row" ) do
            content_tag( :div, capture(&block), class: "small-12 columns #{ options[ :wrapper_classes ] }")
        end
   end

   #errors_for_field() - called line 51
   def errors_for_field( attribute, options = {} )
    return "" if object.errors[ attribute ].empty?
    content_tag( :small, object.errors[ attribute ].to_sentence.capitalize, class: "error" )
   end


    #errors_on? - line 12
    #wrapper_classes - required line 27
    #wrapper block - defined line 25
    #super - calls the class from source
   def text_field( attribute, options = {} )
    options[ :lable ] ||= attribute
    label_text ||= options.delete( :label ).to_s.titleize
    label_options ||= {}
    if errors_on?(attribute)
        wrapper_options = { wrapper_classes: "error" }
    end
    wrapper( wrapper_options ) do
        label( attribute, label_text, label_options ) +
        super( attribute, options ) + errors_for_field(attribute)
    end
   end


end