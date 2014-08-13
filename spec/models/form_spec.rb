# -*- coding: utf-8 -*-
require 'spec_helper'

describe Form, :type => :model do
  describe "#sorted_highlighted_fields" do

    before :each do
        high_attr = [{ :order => "1", :highlighted => true }, { :order => "2", :highlighted => true }, { :order => "10", :highlighted => true }]
        @highlighted_fields = [ Field.new(:name => "h1", :highlight_information => high_attr[0]),
                         Field.new(:name => "h2", :highlight_information => high_attr[1]),
                         Field.new(:name => "h3", :highlight_information => high_attr[2]) ]
        field = Field.new :name => "regular_field"
        form_section1 = FormSection.new( :name => "Highlight Form1", :fields => [@highlighted_fields[0], @highlighted_fields[2], field] )
        form_section2 = FormSection.new( :name => "Highlight Form2", :fields => [@highlighted_fields[1]] )
        @form = build :form, sections: [form_section1, form_section2]
    end

    it "should sort the highlighted fields by highlight order" do
      sorted_highlighted_fields = @form.sorted_highlighted_fields

      expect(sorted_highlighted_fields.map { |field| field.highlight_information.order }).to eq(
        @highlighted_fields.map { |field| field.highlight_information.order }
      )
    end
  end
end