# frozen_string_literal: true

require "immutable-struct"

module ZoomSlack
  Status = ImmutableStruct.new(:text, :emoji, :expires)
end
