class WithdrawalsController < ApplicationController

  def new
    @withdrawal = Withdrawal.new
  end

  def create
    @withdrawal = Withdrawal.new(withdrawal_params)
    if @withdrawal.save
    else
      render :new
    end
  end

  private
  def withdrawal_params
    params.require(:withdrawal).permit(:impression_unuseful, :impression_difficult, :impression_not_enough)
  end

end
