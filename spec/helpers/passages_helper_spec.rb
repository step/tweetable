require 'rails_helper'

RSpec.describe PassagesHelper, type: :helper do
  describe "to_preffered_time_format" do
    it "converts the time into preffered format" do
      expect(helper.to_preffered_time_format(DateTime.new(2017,05,3,4,5,6))).to eq("03-05-2017 04:05AM")
    end
  end

  describe "get_passage_by_status_path" do
    it "appends the status with the get_passage_by_status_path" do
      expect(helper.get_passage_by_status_path("DRAFT")).to eq("/passages/get_passage_by_status/DRAFT")
    end
  end
end
