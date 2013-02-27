require 'spec_helper'

describe IdeaBox::Idea do
  
  describe "Class Methods" do
    describe ".count" do
      it "returns the correct count of ideas" do
        idea = IdeaBox::Idea.new title: "First", description: "Second"
        idea.save
        expect(IdeaBox::Idea.count).to eq 1
      end
      
    end
  end
  
end