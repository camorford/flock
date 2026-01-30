class Admin::PositionsController < ApplicationController
  before_action :set_team

  def new
    @position = @team.positions.new
  end

  def create
    @position = @team.positions.new(position_params)
    if @position.save
      redirect_to admin_team_path(@team), notice: "Position added."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @position = @team.positions.find(params[:id])
    @position.destroy
    redirect_to admin_team_path(@team), notice: "Position removed."
  end

  private

  def set_team
    @team = Team.find(params[:team_id])
  end

  def position_params
    params.require(:position).permit(:name)
  end
end