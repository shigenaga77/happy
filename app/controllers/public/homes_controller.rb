class Public::HomesController < ApplicationController
  def top
    @background_image = "background-image"
  end
  
  def about
    @about_background_image = "background-image2"
  end
end
