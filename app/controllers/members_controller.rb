class MembersController < ApplicationController

  
  def index
    @members = Member.all.order("name ASC")
    respond_to do |format|
      format.html
      format.csv {send_data @members.to_csv }
    end
  end

  def show
    @member = Member.find(params[:id])
    characters = ["0","1","2","3","4","5","6","7","8","9","a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
    @public_id = ""
    for i in 0..63
      @public_id = @public_id + characters[rand(35)]
    end

  end

  def new
    @member = Member.new
  end

  def create
    @member = Member.new

    @member.name = params[:name]
    @member.organization = params[:organization]
    @member.image = params[:image]
    @member.position = params[:position]
    @member.sequence = params[:sequence]
    if params[:active].present?
      @member.active = true
    else
      @member.active = false
    end

    if @member.save
      redirect_to "/members/#{@member.id}", :notice => "Member created successfully."
    else
      render 'new'
    end
  end

  def edit
    @member = Member.find(params[:id])
  end

  def update
    @member = Member.find(params[:id])
    @member.name = params[:name]
    @member.organization = params[:organization]
    @member.image = params[:image]
    @member.position = params[:position]
    @member.sequence = params[:sequence]
    if params[:active].present?
      @member.active = true
    else
      @member.active = false
    end


    if @member.save
      redirect_to "/members/#{@member.id}/", :notice => "Member updated successfully!"
    else
      render 'edit'
    end
  end

  def upload_image
    @member = Member.find(params[:member_id])
    @public_id = params[:public_id]
   

      if @member_image.save
        redirect_to "/members/#{@member.id}", :notice => "Image uploaded successfully."
      else
        redirect_to "/members/#{@member.id}", :alert => "Image failed to upload."
      end
  end

  def open_member

    @member = Member.find(params[:id])
    @member.active = true

    if @member.bids.where(selected: true).present?
      @winner = @member.bids.find_by(selected: true)
      @winner.selected = false
      @winner.save
    end

    if @member.save
      redirect_to "/members/#{@member.id}/", :notice => "Member is now open for bidding!"
    else
      redirect_to "/members/#{@member.id}/", :alert => "Member is still closed for this Item!"
    end
  
  end

    def close_member

    @member = Member.find(params[:id])
    @member.active = false
    if @member.paddle_raise
      if @member.bids.where(selected: true).present?
        @member.bids.where(selected: true).each do |bid |
          bid.selected = false
          bid.save
        end
      end
    else
      if @member.bids.where(rank: 1).present?
        @member.bids.where(selected: true).each do |bid |
          bid.selected = false
          bid.save
        end
        @winner = @member.bids.find_by(rank: 1)
        @winner.selected = true
        @winner.save
      end
    end

    if @member.save
      redirect_to "/members/#{@member.id}/", :notice => "Member has been closed for this Item!"
    else
      redirect_to "/members/#{@member.id}/", :alert => "Member is still open for this Item!"
    end
  
  end

  def update_member_sequence
    @ranks = params[:ranks]
    n = 1
    @ranks.each do | rank |
      member = Member.find(rank.to_i)
      member.item_number = n
      member.save
      n = n + 1
    end
    render('update_member_sequence.js.erb')
  end

  def destroy
    @member = Member.find(params[:id])

    @member.destroy

    redirect_to "/members", :notice => "Member deleted."
  end

  def import
    Member.import(params[:file])
    redirect_to "/models/", notice: "Members imported"
  end

end
