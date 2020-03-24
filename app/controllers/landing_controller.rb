class LandingController < ApplicationController
 
  def index
    render :layout => "landing"
  end

  def board
    @members = Member.all.order(sequence: :asc)
    render :layout => "landing"
  end

  def about_us
    render :layout => "landing"
  end
  
  def contact_us
    render :layout => "landing"
  end
  
  def impact_grants
    render :layout => "landing"
  end
  
  def bbdc
    render :layout => "landing"
  end

  def research
    render :layout => "landing"
  end

  def oif
    render :layout => "landing"
  end

  def golf_outing
    render :layout => "landing"
  end

  def card_game
    render :layout => "landing"
  end

  def newsletter
    render :layout => "landing"
  end

  def photos
    render :layout => "landing"
  end

  def auction
    render :layout => "landing"
  end

  def amazon
    render :layout => "landing"
  end

  def donate
    render :layout => "landing"
  end

  def volunteer
    render :layout => "landing"
  end

end
