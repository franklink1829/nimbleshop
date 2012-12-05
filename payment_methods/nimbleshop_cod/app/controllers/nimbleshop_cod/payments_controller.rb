module NimbleshopCod
  class PaymentsController < ::ActionController::Base

    def create
      order       = Order.find_by_id! session[:order_id]
      order.update_attributes(payment_method: NimbleshopCod::Cod.first)
      order.pending

      respond_to do |format|
        format.html do
          redirect_to main_theme.order_path(order)
        end
      end

    end

  end
end
