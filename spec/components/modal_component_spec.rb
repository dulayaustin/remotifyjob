# frozen_string_literal: true

require "rails_helper"

RSpec.describe ModalComponent, type: :component do
  it "is working correctly" do
    rendered_component = render_inline(ModalComponent.new(title: "Modal Header")) { "Contents in the modal" }.to_html

    expect(rendered_component).to include("<turbo-frame id=\"modal\">")
    expect(rendered_component).to include("Modal Header")
    expect(rendered_component).to include("Contents in the modal")
  end
end
