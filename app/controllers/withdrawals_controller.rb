class WithdrawalsController < ApplicationController

  def new
    @withdrawal = Withdrawal.new
  end

end
