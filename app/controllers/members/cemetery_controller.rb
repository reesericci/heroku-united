class Members::CemeteryController < ApplicationController
  def index
    @members = Member.cemetery
  end
end
