# frozen_string_literal: true

class ModalComponent < ViewComponent::Base
  include Turbo::FramesHelper

  attr_reader :title

  def initialize(title:)
    @title = title
  end
end