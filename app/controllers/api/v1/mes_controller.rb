# Just a demo api controller you can remove this
class Api::V1::MesController < Api::BaseController
  def show
    render json: current_user
  end

  def destroy
    current_user.destroy
    render json: {}
  end
end
