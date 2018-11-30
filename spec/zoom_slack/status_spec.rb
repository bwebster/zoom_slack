# frozen_string_literal: true

RSpec.describe ZoomSlack::Status do
  let(:text) { "foo" }
  let(:emoji) { ":bar:" }
  let(:expires) { 0 }

  subject { described_class.new(text: text, emoji: emoji, expires: expires) }

  it "has text attribute" do
    expect(subject.text).to eq(text)
  end

  it "has emoji attribute" do
    expect(subject.emoji).to eq(emoji)
  end

  it "has expires attribute" do
    expect(subject.expires).to eq(expires)
  end
end
