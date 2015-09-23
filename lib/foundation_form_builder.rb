class FoundationFormBuilder < ActionView::Helpers::FormBuilder
    #so I can user content_tag div
    include ActionView::Helpers::TagHelper
    #capture a block of text
    include ActionView::Helpers::CaptureHelper
    #manipulate text in forms
    include ActionView::Helpers::TextHelper

    attr_accessor :output_buffer

   # <div class = "row">
   #    <div class = "small-12 columns">
   #      <%= f.text_field :title %>
   #    </div>
   #  </div>

   def text_field( attribute, options = {} )
    options[ :lable ] ||= attribute
    #Now I can pass a string with "Now I Have a String"
    label_text ||= options.delete( :label ).to_s.titleize
        wrapper do
        # content_tag(:div, class: "row" ) do
        #     content_tag( :div, class: "small-12 columns") do
                #label
                label( attribute, label_text ) +
                #title, super calls ActionView Helpers text_field
                super( attribute, options )
        #     end
        # end
        end
   end

   def submit( text, options = {} )
        options[ :class ] ||= "button radius expand"
        wrapper do
        # content_tag( :div, class: "row" ) do
        #     content_tag( :div, class: "small-12 columns" ) do
                super(text, options)
            # end
        # end
        end
   end

   def wrapper( options = {}, &block)
        content_tag( :div, class: "row") do
            #by default content tag allows to pass text inside a div content_tag( :div, text, class: "small-12 columns")
            #using Capture Helper I can pass a block of text instead. So It allows me to pass super(text, label_text) inside the block
            content_tag( :div, capture(&block), class: "small-12 columns")
        end
   end

end