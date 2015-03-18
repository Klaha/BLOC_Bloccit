require 'rails_helper'

describe Vote do
  describe "validations" do
    describe "value validation" do
      it "only allows -1 or 1 as values" do

        v = Vote.create(value: 1)
        expect(v.valid?).to eq(true)

        v2 = Vote.create(value: -1)
        expect(v2.valid?).to eq(true)

        bad = Vote.create(value: 2)
        expect(bad.valid?).to eq(false)

      end
    end
  end
end