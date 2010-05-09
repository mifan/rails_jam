class ApplicationController < ActionController::Base
  #protect_from_forgery
  layout 'application'

  before_filter :set_process_name_from_request
  after_filter :unset_process_name_from_request

  def set_process_name_from_request
    $0 = 'r#' + request.path
  end

  def unset_process_name_from_request
    $0 = 'r*' + request.path
  end

end
