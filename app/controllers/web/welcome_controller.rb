# frozen_string_literal: true

class Web::WelcomeController < Web::ApplicationController
  def index
    render html: '', layout: true
  end
end
