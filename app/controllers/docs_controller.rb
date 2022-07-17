class DocsController < ApplicationController
  include IconsHelper
  layout 'docs'
  def welcome
    add_breadcrumb 'Welcome', docs_welcome_path
  end

  def register
    add_breadcrumb 'Getting started'
    add_breadcrumb 'Register', docs_getting_started_register_path
  end

  def create_link
    add_breadcrumb 'Getting started'
    add_breadcrumb 'Create a link', docs_getting_started_create_link_path
  end
end
