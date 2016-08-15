require 'rails_helper'

RSpec.describe ApplicationHelper do

  describe '#coderay' do
    it "should wrap text with CodeRay element" do
      expect(helper.coderay("hello")).to match /<div class="CodeRay">\n.*hello/
    end
  end

end
