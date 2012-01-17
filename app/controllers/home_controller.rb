class HomeController < ApplicationController
  def index
    @seo_title = "doc5，伴你学习，伴你成长,伴你生活"
    respond_to do |format|
      format.html { render :layout => "temporary" }
    end 
  end
end
