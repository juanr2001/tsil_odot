class FoundationFormBuilder < ActionView::Helpers::FormBuilder
    #so I can user content_tag div
    include ActionView::Helpers::TagHelper
    #capture a block of text
    include ActionView::Helpers::CaptureHelper
    #manipulate text in forms
    include ActionView::Helpers::TextHelper

    attr_accessor :output_buffer

   def text_field( attribute, options = {} )
    options[ :lable ] ||= attribute
    label_text ||= options.delete( :label ).to_s.titleize
    label_options ||= {}
    if errors_on?(attribute)
        # label_options[ :class ] = "error"
        # options[ :class ] = "error"
        wrapper_options = { wrapper_classes: "error"}
    end
    wrapper( wrapper_options ) do
        label( attribute, label_text, label_options ) +
        super( attribute, options ) + errors_for_field(attribute)
    end
   end

    def errors_on?( attribute )
        object.errors[ attribute ].size > 0
    end

   def submit( text, options = {} )
        options[ :class ] ||= "button radius expand"
        wrapper do
            super(text, options)
        end
   end

   def wrapper( options = {}, &block)
        content_tag( :div, class: "row") do
            content_tag( :div, capture(&block), class: "small-12 columns #{ options[ :wrapper_classes ] }")
        end
   end

   def errors_for_field( attribute, options = {} )
    return "" if object.errors[ attribute ].empty?
    #since form_for calls an object, I can call the word object here. because is inside the form_for block
    #so the errors are call from the model validations, depending on the model and the attribute.
    content_tag( :small, object.errors[ attribute ].to_sentence.capitalize, class: "error" )
   end

end