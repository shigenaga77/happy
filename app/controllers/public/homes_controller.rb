class Public::HomesController < ApplicationController
  def top
    @background_image = "background-image"
  end
  
  def about
    @background_image = "background-image2"
  end
end
