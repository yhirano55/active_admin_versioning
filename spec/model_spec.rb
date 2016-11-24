require "spec_helper"

describe PaperTrail::Version, type: :model do
  describe "#item_class" do
    subject { described_class.new(item_type: item_type).item_class }

    context "when item_type is correct" do
      let(:item_type) { "Post" }
      it("should return constant") { should eq Post }
    end

    context "when item_type is incorrect" do
      let(:item_type) { "Article" }
      it { should be_nil }
    end
  end

  describe "#item_class_i18n" do
    subject { described_class.new(item_type: item_type).item_class_i18n }

    context "when item_type is correct" do
      let(:item_type) { "Post" }
      it { expect { subject }.not_to raise_error }
    end

    context "when item_type is missing constant" do
      let(:item_type) { "Article" }
      it { expect { subject }.not_to raise_error }
      it("should return item_type") { should eq item_type }
    end
  end

  describe "#item_column_names" do
    subject { described_class.new(item_type: item_type).item_column_names }

    context "when item_type is correct" do
      let(:item_type) { "Post" }
      it { should be_a Array }
    end

    context "when item_type is incorrect" do
      let(:item_type) { "Article" }
      it { expect { subject }.to raise_error(NoMethodError) }
    end
  end

  describe "#item_attributes" do
    subject(:item_attributes) do
      described_class.new(item_type: "Post", object: object).item_attributes
    end

    context "when object is YAML" do
      let(:object) { YAML.dump("id" => 123, "title" => "string", "body" => "string") }
      it { should be_a Hash }
      it "should return expected attributes" do
        item_attributes["id"].should eq 123
        item_attributes["title"].should eq "string"
        item_attributes["body"].should eq "string"
      end
    end

    context "when object is not YAML" do
      let(:object) { nil }
      it { should be_nil }
    end
  end

  describe "#item_instance" do
    subject do
      described_class.new(item_type: "Post", object: object).item_instance
    end

    context "when instance can build" do
      let(:object) { YAML.dump("id" => 123, "title" => "string", "body" => "string") }
      it { should be_a Post }
    end

    context "when instance cannot build" do
      let(:object) { nil }
      it { should be_nil }
    end
  end

  describe "#event_i18n" do
    subject { described_class.new(event: "create").event_i18n }
    it { should eq "create" }
  end
end
