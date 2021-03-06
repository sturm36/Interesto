class PinsController < ApplicationController
  before_action :find_pin, only:[:show,:edit,:update,:destroy,:upvote]
  before_action :authenticate_user!,except:[:index,:show]
  def index
    @pins = Pin.all.order("created_at Desc").paginate(page: params[:page], per_page: 9)
  end

  def new
    @pin = current_user.pins.build
  end

  def create
    @pin = current_user.pins.build(pin_params)

    if @pin.save!
      redirect_to @pin, notice: "Successfully created new Pin"
    else
      render 'new', notice: "Please Enter again"
    end
  end

  def show
  end

  def edit
  end

  def destroy
    @pin.destroy
    redirect_to root_path
  end
  def upvote_by
    @pin.upvote_by current_user
    redirect_to :back
  end

  def update
    if @pin.update(pin_params)
      redirect_to @pin , notice: "Pin is successfully updated"
    else
      render 'edit'
    end
  end

  private

  def pin_params
    params.require(:pin).permit(:title,:description,:image)
  end

  def find_pin
    @pin =Pin.find(params[:id])
  end

end
